Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Aug 2007 02:09:12 +0100 (BST)
Received: from rv-out-0910.google.com ([209.85.198.190]:54717 "EHLO
	rv-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20022592AbXH3BJE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 30 Aug 2007 02:09:04 +0100
Received: by rv-out-0910.google.com with SMTP id l15so21296rvb
        for <linux-mips@linux-mips.org>; Wed, 29 Aug 2007 18:08:45 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mC2NpYxOG7WwuegGQYiGHM0WkhIGTZ1rKEF97epkUu+G6Yu2I+Frme4CQZsCqGm5rS6C1BT2mnj0fkmC9hBatfYGElWEMbktJTi73BcREPPU8110LE2wnX1MvbhVPoUWvyMWz3Wj3wHkFPshXLw3JU6tI0/4e4cvlJ3gwwUcdbU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BxxDuWlfWHErT5w87oWNghqleMZYg8bJYt8KAzhJ3WNNhYE+NwW98d6X0i2Ssd28KdN7XrAXiXk8tde6oEK0bGw7F4ly6ZD1RNnZtKRoyEWflhfm5GVWysCohhk79/P4sESLl+cE8pu8JKO7s+Pba24dyXki7ml5dEaPFPxfRxY=
Received: by 10.114.197.1 with SMTP id u1mr594276waf.1188436124943;
        Wed, 29 Aug 2007 18:08:44 -0700 (PDT)
Received: by 10.114.155.13 with HTTP; Wed, 29 Aug 2007 18:08:44 -0700 (PDT)
Message-ID: <50f30abd0708291808m513ad137v8dda3890713b6c51@mail.gmail.com>
Date:	Wed, 29 Aug 2007 18:08:44 -0700
From:	"guo guo" <sunnyboyguo@gmail.com>
To:	"David Daney" <ddaney@avtrex.com>
Subject: Re: problem about the tool chain for R3000
Cc:	linux-mips@linux-mips.org
In-Reply-To: <46D60675.2070709@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: base64
Content-Disposition: inline
References: <50f30abd0708291609i72e4aa57oce757d79a7e87fd6@mail.gmail.com>
	 <46D60675.2070709@avtrex.com>
Return-Path: <sunnyboyguo@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sunnyboyguo@gmail.com
Precedence: bulk
X-list: linux-mips

RGVhciBEYW5leSwKVGhhbmsgeW91IHZlcnkgbXVjaC4KVW5kZXIgbnB0bCBkaXJlY3RvcnksIHRo
ZXJlIGFyZSA2IHBsYWNlcyB1c2UgcmRod3IgaW5zdHJ1Y3Rpb24uIFdoYXQncwpkaWZmZXJlbmNl
IGJldHdlZW4gcmRod3IgYW5kIG1vdmUgaW5zdHJ1Y3Rpb25zPwpDb3VsZCBJIHVzZSBtb3ZlIG9y
IG90aGVyIHIzMDAwIGluc3RydWN0aW9ucyB0byByZXBsYWNlIHJkaHdyPwoKQW5kIEkgZGlkbid0
IGZpbmQgbGwvc2MgaW5zdHJ1Y3Rpb25zIGluIGxpYmMtMi41LjkwLnNvLiBtYXliZSBnY2MKYXZv
aWQgdGhlbSBmb3IgUjMwMDAgY2hpcC4KCkJlc3QgcmVnYXJkcywKVG9ueQoKCjIwMDcvOC8yOSwg
RGF2aWQgRGFuZXkgPGRkYW5leUBhdnRyZXguY29tPjoKPiBndW8gZ3VvIHdyb3RlOgo+ID4gRGVh
ciBBbGwsCj4gPgo+ID4gSSdtIHRyeWluZyB0byBidWlsZCB0b29sIGNoYWluIHdpdGggZ2NjNC4y
LCBiaW51dGlsczIuMTcgYW5kIGdsaWJjMi41Cj4gPiBmb3IgbWlwcyByMzAwMCBjaGlwLgo+ID4g
RHVyaW5nIGNvbmZpZ3VyZSBnY2MgSSBhZGQgqENtYWJpPTMyIKhDbWFyY2g9cjMwMDAgqENtdHVu
ZT1yMzAwMC4gYW5kCj4gPiBkdXJpbmcgYnVpbGRpbmcgZ2xpYmMsIEkgYWRkIENGTEFHUz0gLU8y
IKhDbWFiaT0zMiCoQ21hcmNoPXIzMDAwCj4gPiCoQ210dW5lPXIzMDAwLAo+ID4gVGhlbiBJIGRp
c3NlbWJsZWQgdGhlIGxpYmMtMi41LjkwLnNvIHRvIGNoZWNrIHRoZSBpbnN0cnVjdGlvbnMuIEkK
PiA+IGZvdW5kIGl0IGhhcyB0d28gaW5zdHJ1Y3Rpb25zIHJkaHdyKDB4N2MwM2U4M2IpIGFuZCBz
eW5jKDB4MDAwMDAwMGYpCj4gPiB0aGF0IGRvbid0IGJlbG9uZ3MgdG8gbWlwcyByMzAwMC4KPgo+
IFRoZSByZGh3ciBhbmQgc3luYyBhcmUgdXNlZCBieSB0aGUgTlBUTCBwdGhyZWFkIGxpYnJhcnkg
YW5kIG11c3QgYmUKPiBlbXVsYXRlZCBieSB0aGUgbGludXgga2VybmVsLiAgUHJvYmFibHkgeW91
IHdpbGwgc2VlIGxsIGFuZCBzYyBpbiB0aGVyZQo+IGFzIHdlbGwuICBJZiB5b3UgdXNlIGdsaWJj
Mi4zLnggd2l0aCBMaW51eCB0aHJlYWRzIHRoZW4gdGhlIHJkaHdyIHdpbGwKPiBub3QgYmUgZ2Vu
ZXJhdGVkLgo+Cj4gIFByb2JhYmx5IGlmIHlvdSBkaWQgbm90IHVzZSBsaWJwdGhyZWFkIHlvdSB3
b3VsZCBub3QgbmVlZCBhbnkgb2YgdGhlCj4gdGhyZWFkIHN5bmNocm9uaXphdGlvbiBwcmltaXRp
dmVzIHRoYXQgY2F1c2UgbGwsc2MsIGFuZCBzeW5jIHRvIGJlCj4gZ2VuZXJhdGVkLgo+Cj4gQnV0
IGlmIHlvdSB3YW50IGxpYnB0aHJlYWQgYW5kIHlvdXIgQ1BVIGRvZXMgbm90IHN1cHBvcnQgdGhl
Cj4gaW5zdHJ1Y3Rpb25zLCB5b3Ugd2lsbCBoYXZlIHRvIGVtdWxhdGUgdGhlbS4KPgo+Cj4gRGF2
aWQgRGFuZXkKPgo=
