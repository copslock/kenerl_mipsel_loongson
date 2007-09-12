Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Sep 2007 04:30:54 +0100 (BST)
Received: from wa-out-1112.google.com ([209.85.146.176]:40129 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20021343AbXILDao (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Sep 2007 04:30:44 +0100
Received: by wa-out-1112.google.com with SMTP id m16so84713waf
        for <linux-mips@linux-mips.org>; Tue, 11 Sep 2007 20:30:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=3El1LhmnAHlwxQ0qcFFW9qphOg7y+mBD7lfz/nj90Yc=;
        b=rW5cssBiI0c8BxcQim0TEJJw9h/tY5qhmK50vQhDUmzvpqVp79UTpp/5YDxWq0QFBw03fWepW3tS1KFWAfQiOBvqfaG0tre/KrhpPk+d+cR8ck3a3hY+lYrdUwXRd3nbF7p2B6P2h2b7iPpwDQiZ8uGa1WaNSe++3fjoTYAu3bQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pu1YKwgUrwPBN85PGaDe5hWaalf6aDxw61nxgnYcDJqpwt6Vi/HhskLwWnV9KAPVh7QWBnNcCzf2yXwgOb92+AvPiX7G8OMctmOeZVt5SQPR3HYFRSOIon59QqSCSEikyQpms/fVthOKh4HURARQXlp/uU4wixVEhh0L2ShSToo=
Received: by 10.142.128.6 with SMTP id a6mr349443wfd.1189567832419;
        Tue, 11 Sep 2007 20:30:32 -0700 (PDT)
Received: by 10.142.90.18 with HTTP; Tue, 11 Sep 2007 20:30:32 -0700 (PDT)
Message-ID: <5861a7880709112030w313f5955i892dce4d097b730d@mail.gmail.com>
Date:	Wed, 12 Sep 2007 07:30:32 +0400
From:	"Dajie Tan" <jiankemeng@gmail.com>
To:	zhuzhenhua <zzh.hust@gmail.com>
Subject: Re: does the SAVE_ALL nesting in kernel?
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <5861a7880709112017ue2d5d55k6e722f73daedbd9d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Content-Disposition: inline
References: <50c9a2250709111921g1b49cb0du7f97ebb3e1fb7d07@mail.gmail.com>
	 <5861a7880709112017ue2d5d55k6e722f73daedbd9d@mail.gmail.com>
Return-Path: <jiankemeng@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiankemeng@gmail.com
Precedence: bulk
X-list: linux-mips

WW91IGNhbiBzZWUgdGhpcyBkb2N1bWVudCBmb3IgbW9yZSBkZXRhaWxzOgoKaHR0cDovL3d3dy54
dHJqLm9yZy9taXBzL2RlZmF1bHQuaHRtCgpvciB0aGUgZG9jdW1lbnQgZm9yIGFuYWx5c2luZyB0
aGUgcHJvY2VzcyBvZiBleGNlcHRpb24gYW5kIGludGVycnVwdApvZiBtaXBzIGxpbnV4OgoKaHR0
cDovL3Blb3BsZS5vcGVucmF5cy5vcmcvfmNvbWNhdC9teWRvYy9taXBzLmxpbnV4LmludGVyLnBk
ZgoKCgoKMjAwNy85LzEyLCBEYWppZSBUYW4gPGppYW5rZW1lbmdAZ21haWwuY29tPjoKPiBXaGlj
aCBleGNlcHRpb24gaGFuZGxlciBkbyB5b3Ugd2FudCB0byBiZSBuZXN0ZWQ/Cj4KPiBJZiBpdCdz
IG5vdCBhIGludGVycnVwdCBoYW5kbGVyIHlvdSBjYW4gdXNlIFNUSShlbmFibGUgaW50ZXJydXB0
cykgb3IKPiBDTEkoZGlzYWJsZSBpbnRlcnJ1cHRzKSBhZnRlciBTQVZFX0FMTCBmb3IgbmVzdGlu
ZyBzdXBwb3J0LiBUaGV5IGFsbAo+IGNsZWFyIEVYTCBiaXQgaW4gQ1AwX1NUQVRVUyByZWdpc3Rl
ciBhbmQgc2V0IHRoZSBLU1U9MDAuCj4KPgo+IDIwMDcvOS8xMiwgemh1emhlbmh1YSA8enpoLmh1
c3RAZ21haWwuY29tPjoKPiA+IGhlbGxvLCBhbGwKPiA+ICAgICAgICAgICAgICBpIGhhdmUgYSBt
aXBzIGJvYXJkLCAgYW5kIHRoZSBTRFJBTSBzcGVlZChidXMgY2xvY2spIGlzIG5vdCB0b28KPiA+
IGZhc3QuCj4gPiAgICAgICAgICAgICAgIHNvIGkgd2FudCBjaGFuZ2UgIHRoZSBTQVZFX0FMTCBh
bmQgUkVTVE9SRV9BTEwgdG8gdXNlCj4gPiBpbnRlcm5hbC1yYW0oaGlnaCBzcGVlZCkuCj4gPiAg
ICAgICAgICAgICAgaSBqdXN0IHdvbmRlciB3aGV0aGVyIHRoZSBTQVZFX0FMTCBuZXRzdGluZyBp
biBrZXJuZWwgIGZvciBtaXBzCj4gPiBhcmNoPwo+ID4gICAgICAgICAgICAgIGlmIG5vdCwgaSB0
aGluayAgbWF5YmUgMWsgYnl0ZSBmb3IgU0FWRV9BTEwgaXMgZW5vdWdoKCAzMnJlZ3MKPiA+IFg0
LCBhbmQgc29tZSBjcDBfcmVncykuCj4gPiAgICAgICAgICAgICAgYnV0IGlmICB0aGUgU0FWRV9B
TEwgbmVzdGluZywgbWF5YmUgaSBuZWVkIHRvIGtlZXAgYSBzdGFjayBpbgo+ID4gaW50ZXJuYWwt
cmFtLgo+ID4gICAgICAgICAgICAgIHRoYW5rcyBmb3IgYW55IGhpbnRz77yOCj4gPgo+ID4gIEJl
c3QgUmVnYXJkcwo+ID4KPiA+ICAtLQo+ID4gIHp6aAo+ID4KPiA+Cj4KPgo+IC0tCj4g5Li65aSp
5Zyw56uL5b+DCj4g5Li655Sf5rCR56uL5ZG9Cj4g5Li65b6A5Zyj57un57ud5a2mCj4g5Li65LiH
5LiW5byA5aSq5bmzCj4KCgotLSAK5Li65aSp5Zyw56uL5b+DCuS4uueUn+awkeeri+WRvQrkuLrl
voDlnKPnu6fnu53lraYK5Li65LiH5LiW5byA5aSq5bmzCg==
