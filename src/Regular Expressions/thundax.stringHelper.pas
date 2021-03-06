//  Copyright (c) 2012-2013, Jordi Corbilla
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  - Redistributions of source code must retain the above copyright notice,
//    this list of conditions and the following disclaimer.
//  - Redistributions in binary form must reproduce the above copyright notice,
//    this list of conditions and the following disclaimer in the documentation
//    and/or other materials provided with the distribution.
//  - Neither the name of this library nor the names of its contributors may be
//    used to endorse or promote products derived from this software without
//    specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.

unit thundax.stringHelper;

interface

uses
  thundax.stringHelper.contract, RegularExpressions;

type
  TStringHelper = class(TInterfacedObject, IStringHelper)
  private
    FText : string;
    function GetText : string;
    procedure SetText(const Value : string);
  public
    property Text : string read GetText write SetText;
    constructor Create(text : string);
    class function New(text : string) : IStringHelper;
    function Left(numChars : Integer) : IStringHelper;
    function Right(numChars : Integer) : IStringHelper;
    function isMatch(regEx : string) : Boolean;
    function MatchGroups(regEx: string): TGroupCollection;
    function ToString() : string; override;
  end;

implementation

uses
  AnsiStrings, StrUtils;

{ TStringHelper }

constructor TStringHelper.Create(text: string);
begin
  FText := text;
end;

function TStringHelper.GetText: string;
begin
  result := FText;
end;

function TStringHelper.isMatch(regEx: string): Boolean;
var
  expression: TRegEx;
begin
  expression := TRegEx.Create(regEx);
  result := expression.IsMatch(GetText);
end;

function TStringHelper.MatchGroups(regEx: string): TGroupCollection;
var
  expression: TRegEx;
begin
  expression := TRegEx.Create(regEx);
  result := expression.Match(GetText).Groups;
end;

function TStringHelper.Left(numChars: Integer): IStringHelper;
begin
  SetText(AnsiLeftStr(GetText, numChars));
  result := Self;
end;

class function TStringHelper.New(text : string): IStringHelper;
begin
  result := Create(text);
end;

function TStringHelper.Right(numChars: Integer): IStringHelper;
begin
  SetText(AnsiRightStr(GetText, numChars));
  result := Self;
end;

procedure TStringHelper.SetText(const Value: string);
begin
  FText := Value;
end;

function TStringHelper.ToString: string;
begin
  result := FText;
end;

end.
