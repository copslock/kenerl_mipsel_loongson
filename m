Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Sep 2007 04:17:34 +0100 (BST)
Received: from nz-out-0506.google.com ([64.233.162.225]:9696 "EHLO
	nz-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20021444AbXILDR0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Sep 2007 04:17:26 +0100
Received: by nz-out-0506.google.com with SMTP id n1so42769nzf
        for <linux-mips@linux-mips.org>; Tue, 11 Sep 2007 20:17:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=hjqDP28Octbk8Bfu59wV8yCOgvKAyjAWHZomrYmmgXQ=;
        b=cNfzFciO559cSV+ONlCw75F3zhnYSeJtgKkuupMN4R7jzVegIUB63D9yevCSA/MkILaVbR0tV9HASIpQ850UmmEHAnk1MFI6nm6RLUS+k707GG/qRZNZqZLFKnSojb+OLDA3zC++7ImClsFsAO7SG9QoXwl/Fx7i+TIQx/O57AI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o+2iE8Fts8ewMI7Cnj4QbJjQ9mClLnpxcrvnYjwcpK77QwCfw46Z5HIuYSR9f4fvLoKetteChb89Qfjk2y4jdGhbexE/tNmlblME6+hoA8tjdx1BF77xaTh6L7P0Z1NRN9S+94Ni75va8wNNjr3XO2W/cmrXf9AQm/dRvx2BXA0=
Received: by 10.143.10.15 with SMTP id n15mr348199wfi.1189567027092;
        Tue, 11 Sep 2007 20:17:07 -0700 (PDT)
Received: by 10.142.90.18 with HTTP; Tue, 11 Sep 2007 20:17:07 -0700 (PDT)
Message-ID: <5861a7880709112017ue2d5d55k6e722f73daedbd9d@mail.gmail.com>
Date:	Wed, 12 Sep 2007 07:17:07 +0400
From:	"Dajie Tan" <jiankemeng@gmail.com>
To:	zhuzhenhua <zzh.hust@gmail.com>
Subject: Re: does the SAVE_ALL nesting in kernel?
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <50c9a2250709111921g1b49cb0du7f97ebb3e1fb7d07@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Content-Disposition: inline
References: <50c9a2250709111921g1b49cb0du7f97ebb3e1fb7d07@mail.gmail.com>
Return-Path: <jiankemeng@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16465
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiankemeng@gmail.com
Precedence: bulk
X-list: linux-mips

V2hpY2ggZXhjZXB0aW9uIGhhbmRsZXIgZG8geW91IHdhbnQgdG8gYmUgbmVzdGVkPwoKSWYgaXQn
cyBub3QgYSBpbnRlcnJ1cHQgaGFuZGxlciB5b3UgY2FuIHVzZSBTVEkoZW5hYmxlIGludGVycnVw
dHMpIG9yCkNMSShkaXNhYmxlIGludGVycnVwdHMpIGFmdGVyIFNBVkVfQUxMIGZvciBuZXN0aW5n
IHN1cHBvcnQuIFRoZXkgYWxsCmNsZWFyIEVYTCBiaXQgaW4gQ1AwX1NUQVRVUyByZWdpc3RlciBh
bmQgc2V0IHRoZSBLU1U9MDAuCgoKMjAwNy85LzEyLCB6aHV6aGVuaHVhIDx6emguaHVzdEBnbWFp
bC5jb20+Ogo+IGhlbGxvLCBhbGwKPiAgICAgICAgICAgICAgaSBoYXZlIGEgbWlwcyBib2FyZCwg
IGFuZCB0aGUgU0RSQU0gc3BlZWQoYnVzIGNsb2NrKSBpcyBub3QgdG9vCj4gZmFzdC4KPiAgICAg
ICAgICAgICAgIHNvIGkgd2FudCBjaGFuZ2UgIHRoZSBTQVZFX0FMTCBhbmQgUkVTVE9SRV9BTEwg
dG8gdXNlCj4gaW50ZXJuYWwtcmFtKGhpZ2ggc3BlZWQpLgo+ICAgICAgICAgICAgICBpIGp1c3Qg
d29uZGVyIHdoZXRoZXIgdGhlIFNBVkVfQUxMIG5ldHN0aW5nIGluIGtlcm5lbCAgZm9yIG1pcHMK
PiBhcmNoPwo+ICAgICAgICAgICAgICBpZiBub3QsIGkgdGhpbmsgIG1heWJlIDFrIGJ5dGUgZm9y
IFNBVkVfQUxMIGlzIGVub3VnaCggMzJyZWdzCj4gWDQsIGFuZCBzb21lIGNwMF9yZWdzKS4KPiAg
ICAgICAgICAgICAgYnV0IGlmICB0aGUgU0FWRV9BTEwgbmVzdGluZywgbWF5YmUgaSBuZWVkIHRv
IGtlZXAgYSBzdGFjayBpbgo+IGludGVybmFsLXJhbS4KPiAgICAgICAgICAgICAgdGhhbmtzIGZv
ciBhbnkgaGludHPvvI4KPgo+ICBCZXN0IFJlZ2FyZHMKPgo+ICAtLQo+ICB6emgKPgo+CgoKLS0g
CuS4uuWkqeWcsOeri+W/gwrkuLrnlJ/msJHnq4vlkb0K5Li65b6A5Zyj57un57ud5a2mCuS4uuS4
h+S4luW8gOWkquW5swo=
