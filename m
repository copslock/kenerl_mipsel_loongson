Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2008 14:54:32 +0100 (BST)
Received: from yw-out-1718.google.com ([74.125.46.153]:64623 "EHLO
	yw-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20031540AbYELNy3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 May 2008 14:54:29 +0100
Received: by yw-out-1718.google.com with SMTP id 9so1407276ywk.24
        for <linux-mips@linux-mips.org>; Mon, 12 May 2008 06:54:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        bh=ei9Y7FZi7xnmwNXMLXJEw+Z0PxsDgD1rwSdQtyPGpCc=;
        b=sj7+EoazzUxQ6yF6VRO3lctwnc0NYn4s7QXkK6UU3MHuQZknBIljh0TXn/ARPq2HQMkxWgTLDXRzpU+uTFBdLZenp4u13yjl31c2n//4xPQmhLwS9YSfuZKI0yQ6s6EU5dD68n+sIykrnNVvIjkWXfior3exbcNxrfLDnwreROQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=q1/zLreiHlC8+WZ6jLqA0a+ED/27z+n7fxguQnpVeaD2Am6tRtIOznGHodv6QMtaHqFK/6R4K6+Kqg+voeAaomx1BoBWdXZasFMiWiWFOobhjD4mJ9PVDUirjDvUkKpmRaGQ6Ht7h3lHthWzFt9tEZOSpd8n8vJVtSG9kNHExek=
Received: by 10.150.84.20 with SMTP id h20mr8186175ybb.205.1210600464623;
        Mon, 12 May 2008 06:54:24 -0700 (PDT)
Received: by 10.150.140.6 with HTTP; Mon, 12 May 2008 06:54:24 -0700 (PDT)
Message-ID: <90edad820805120654n50f7a00cm3c7b4a4f9346d5ea@mail.gmail.com>
Date:	Mon, 12 May 2008 17:54:24 +0400
From:	"Dmitri Vorobiev" <dmitri.vorobiev@gmail.com>
To:	"Martin Michlmayr" <tbm@cyrius.com>
Subject: Re: ext4dev build failure on mips: "empty_zero_page" undefined
Cc:	linux-mips@linux-mips.org, linux-ext4@vger.kernel.org
In-Reply-To: <20080512130604.GA15008@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1197_20411098.1210600464680"
References: <20080512130604.GA15008@deprecation.cyrius.com>
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_1197_20411098.1210600464680
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2008/5/12 Martin Michlmayr <tbm@cyrius.com>:
> I get the following build failure on MIPS Malta with 2.6.26-rc1:
>
>   MODPOST 1516 modules
>  ERROR: "empty_zero_page" [fs/ext4/ext4dev.ko] undefined!
>
>  Any idea?  A missing export?

Yep. The export is missing. Attached patch was build-tested for a
Malta config with ext4 enabled as a module.

Dmitri

------=_Part_1197_20411098.1210600464680
Content-Type: text/x-patch;
 name=0001-MIPS-Export-empty_zero_page-as-a-GPL-symbol.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fg54936a0
Content-Disposition: attachment;
 filename=0001-MIPS-Export-empty_zero_page-as-a-GPL-symbol.patch

RnJvbSBjYjU1ZWQ3ZDk1OGNmNGFiYjU4ZGQxZDZlNDZlMDk0NDdiNTY5NGIwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEbWl0cmkgVm9yb2JpZXYgPGRtaXRyaS52b3JvYmlldkBnbWFp
bC5jb20+CkRhdGU6IE1vbiwgMTIgTWF5IDIwMDggMTc6NDk6MTkgKzA0MDAKU3ViamVjdDogW1BB
VENIIDEvMV0gW01JUFNdIEV4cG9ydCBlbXB0eV96ZXJvX3BhZ2UgYXMgYSBHUEwgc3ltYm9sCgpU
aGUgZW1wdHlfemVyb19wYWdlIHN5bWJvbCBpcyBuZWVkZWQgZm9yIHRoZSBleHQ0IGRyaXZlciBh
bmQKc2hvdWxkIHRoZXJlZm9yZSBiZSBleHBvcnRlZC4gVGhpcyBmaXhlcyB0aGUgZm9sbG93aW5n
IGVycm9yCnJlcG9ydGVkIGJ5IE1hcnRpbiBNaWNobG1heXI6Cgo+Pj4+Pj4+CgpNT0RQT1NUIDE1
MTYgbW9kdWxlcwpFUlJPUjogImVtcHR5X3plcm9fcGFnZSIgW2ZzL2V4dDQvZXh0NGRldi5rb10g
dW5kZWZpbmVkIQoKPj4+Pj4+CgpTaWduZWQtb2ZmLWJ5OiBEbWl0cmkgVm9yb2JpZXYgPGRtaXRy
aS52b3JvYmlldkBnbWFpbC5jb20+Ci0tLQogYXJjaC9taXBzL21tL2luaXQuYyB8ICAgIDUgKysr
Ky0KIDEgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2FyY2gvbWlwcy9tbS9pbml0LmMgYi9hcmNoL21pcHMvbW0vaW5pdC5jCmluZGV4
IGVjZDU2MmQuLjYxOGE0MTggMTAwNjQ0Ci0tLSBhL2FyY2gvbWlwcy9tbS9pbml0LmMKKysrIGIv
YXJjaC9taXBzL21tL2luaXQuYwpAQCAtNzAsNyArNzAsMTAgQEAgREVGSU5FX1BFUl9DUFUoc3Ry
dWN0IG1tdV9nYXRoZXIsIG1tdV9nYXRoZXJzKTsKICAqIGFueSBwcmljZS4gIFNpbmNlIHBhZ2Ug
aXMgbmV2ZXIgd3JpdHRlbiB0byBhZnRlciB0aGUgaW5pdGlhbGl6YXRpb24gd2UKICAqIGRvbid0
IGhhdmUgdG8gY2FyZSBhYm91dCBhbGlhc2VzIG9uIG90aGVyIENQVXMuCiAgKi8KLXVuc2lnbmVk
IGxvbmcgZW1wdHlfemVyb19wYWdlLCB6ZXJvX3BhZ2VfbWFzazsKK3Vuc2lnbmVkIGxvbmcgZW1w
dHlfemVyb19wYWdlOworRVhQT1JUX1NZTUJPTF9HUEwoZW1wdHlfemVyb19wYWdlKTsKKwordW5z
aWduZWQgbG9uZyB6ZXJvX3BhZ2VfbWFzazsKIAogLyoKICAqIE5vdCBzdGF0aWMgaW5saW5lIGJl
Y2F1c2UgdXNlZCBieSBJUDI3IHNwZWNpYWwgbWFnaWMgaW5pdGlhbGl6YXRpb24gY29kZQotLSAK
MS41LjMKCg==
------=_Part_1197_20411098.1210600464680--
