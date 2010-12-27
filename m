Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Dec 2010 15:01:02 +0100 (CET)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:35131 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490996Ab0L0OA7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Dec 2010 15:00:59 +0100
Received: by qwj9 with SMTP id 9so8628192qwj.36
        for <linux-mips@linux-mips.org>; Mon, 27 Dec 2010 06:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=7oJMEzcl8s4upHe6PVBacmTTHziHpkuiHjog8M8pOpc=;
        b=TLJDYMirKhdNKMVxZy8V5cqdZb7Gnbp1h45IGON/nwXtNj0rffE3fhEVfy48HEQxUH
         5Mh/S1aMifpXzaQoP6omFB0LWQbBZTLeRih4VpYfUgAMPT+GzfNC8qS8lkzIw6NC0Amc
         hxYj4dH9o18b/oHtS6nlOHs/++bxI0CNRGc8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=Zv+88mA0jl6xEN9eAXGOr6naLqzUEjfrwQ80xmXrwXfRa4qgkomxtvxUH4sXtl0slf
         vEzne09/PiS1V9b627jM9QCQCX1wKGJude2mpRYSUwleLQkZ5nfHgQrAyKnzJWozFcgB
         QH1wSiOKsvqqRN2ccelxsiAZ0Hg6IDDS7bc+o=
MIME-Version: 1.0
Received: by 10.229.242.77 with SMTP id lh13mr10319402qcb.194.1293458452801;
 Mon, 27 Dec 2010 06:00:52 -0800 (PST)
Received: by 10.229.111.99 with HTTP; Mon, 27 Dec 2010 06:00:52 -0800 (PST)
In-Reply-To: <AANLkTinhM4PUmLbWeAyavf-JPM1Xpu9pJVkXDq4c-f0C@mail.gmail.com>
References: <AANLkTinhM4PUmLbWeAyavf-JPM1Xpu9pJVkXDq4c-f0C@mail.gmail.com>
Date:   Mon, 27 Dec 2010 22:00:52 +0800
Message-ID: <AANLkTinsQrZJsXt0SKRfe3S0cNGT+uuW-t3Jo4Ob4=B4@mail.gmail.com>
Subject: Re: Problem About Vectored interrupt
From:   "Dennis.Yxun" <dennis.yxun@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: multipart/mixed; boundary=00163630ffe39c6af2049864c3f4
Return-Path: <dennis.yxun@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dennis.yxun@gmail.com
Precedence: bulk
X-list: linux-mips

--00163630ffe39c6af2049864c3f4
Content-Type: multipart/alternative; boundary=00163630ffe39c6aeb049864c3f2

--00163630ffe39c6aeb049864c3f2
Content-Type: text/plain; charset=UTF-8

HI:
   Here is my patch which hacked set_vi_srs_handler, with this I could
successfully bring timer(compare/counter),
   But I still not reach the root problem,
Could someone shine some lights on me.
   Thanks

Dennis


On Mon, Dec 27, 2010 at 4:40 PM, Dennis.Yxun <dennis.yxun@gmail.com> wrote:

> HI ALL:
>     I'm try to porting kernel-2.6.36 to one mips24kc board, seems it can't
> bind vectored irq 7 to timer interrupt.
> The hardware wired IP7 to timer interrupt (CP0 compare/counter interrupt)
>     I implemented my own time.c, use set_vi_handler to map
> cp0_compare_irq(value: 7) to mips_timer_dispatch,
>  but weird problem, it didn't successfully map to mips_timer_dispatch, but
> print out "Caught unexpected vectored interrupt."
> which means it still use " static asmlinkage void do_default_vi(void)"  [1]
>
>    My question is : why first call to "set_vi_srs_handler" successfully
> mapped to vectored irq7 [2]
> but later is fail[3], see my attached file, bad_kernel.txt
>
> Dennis
>
>
> [1] arch/mips/kernel/traps.c 1339
> [2] arch/mips/kernel/traps.c  1436, when addr == NULL
> [3] my attached file time.c get_c0_compare_int
>
>

--00163630ffe39c6aeb049864c3f2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

HI:<div>=C2=A0=C2=A0 Here is my patch which hacked set_vi_srs_handler, with=
 this I could successfully bring timer(compare/counter),</div><div>=C2=A0=
=C2=A0 But I still not reach the root problem,</div><div>Could someone shin=
e some lights on me.</div>
<div>=C2=A0=C2=A0 Thanks</div><div><br></div><div>Dennis</div><div><br><br>=
<div class=3D"gmail_quote">On Mon, Dec 27, 2010 at 4:40 PM, Dennis.Yxun <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:dennis.yxun@gmail.com">dennis.yxun@gma=
il.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;">HI ALL:<br>=C2=A0=C2=A0=C2=A0 I&#39;m try t=
o porting kernel-2.6.36 to one mips24kc board, seems it can&#39;t bind vect=
ored irq 7 to timer interrupt.<br>
The hardware wired IP7 to timer interrupt (CP0 compare/counter interrupt)<b=
r>=C2=A0=C2=A0=C2=A0 I implemented my own time.c, use set_vi_handler to map=
 cp0_compare_irq(value: 7) to mips_timer_dispatch,<br>
=C2=A0but weird problem, it didn&#39;t successfully map to mips_timer_dispa=
tch, but print out &quot;Caught unexpected vectored interrupt.&quot;<br>whi=
ch means it still use &quot; static asmlinkage void do_default_vi(void)&quo=
t;=C2=A0 [1]<br>

<br>=C2=A0=C2=A0 My question is : why first call to &quot;set_vi_srs_handle=
r&quot; successfully mapped to vectored irq7 [2]<br>but later is fail[3], s=
ee my attached file, bad_kernel.txt<br><br>Dennis<br><br><br>[1] arch/mips/=
kernel/traps.c 1339<br>

[2] arch/mips/kernel/traps.c=C2=A0 1436, when addr =3D=3D NULL<br>[3] my at=
tached file time.c get_c0_compare_int<br><br>
</blockquote></div><br></div>

--00163630ffe39c6aeb049864c3f2--
--00163630ffe39c6af2049864c3f4
Content-Type: text/x-patch; charset=US-ASCII; name="mips_timer.patch"
Content-Disposition: attachment; filename="mips_timer.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gi7fw7yv2

ZGlmZiAtLWdpdCBhL2FyY2gvbWlwcy9rZXJuZWwvdHJhcHMuYyBiL2FyY2gvbWlwcy9rZXJuZWwv
dHJhcHMuYwppbmRleCBlOTcxMDQzLi5lYWQ4NzUwIDEwMDY0NAotLS0gYS9hcmNoL21pcHMva2Vy
bmVsL3RyYXBzLmMKKysrIGIvYXJjaC9taXBzL2tlcm5lbC90cmFwcy5jCkBAIC0xMzc3LDYgKzEz
NzcsMTEgQEAgc3RhdGljIGFzbWxpbmthZ2Ugdm9pZCBkb19kZWZhdWx0X3ZpKHZvaWQpCiAJcGFu
aWMoIkNhdWdodCB1bmV4cGVjdGVkIHZlY3RvcmVkIGludGVycnVwdC4iKTsKIH0KIAorc3RhdGlj
IGFzbWxpbmthZ2Ugdm9pZCBtaXBzX3RpbWVyX2Rpc3BhdGNoKHZvaWQpCit7CisJZG9fSVJRKDcp
OworfQorCiBzdGF0aWMgdm9pZCAqc2V0X3ZpX3Nyc19oYW5kbGVyKGludCBuLCB2aV9oYW5kbGVy
X3QgYWRkciwgaW50IHNycykKIHsKIAl1bnNpZ25lZCBsb25nIGhhbmRsZXI7CkBAIC0xMzg4LDcg
KzEzOTMsMTQgQEAgc3RhdGljIHZvaWQgKnNldF92aV9zcnNfaGFuZGxlcihpbnQgbiwgdmlfaGFu
ZGxlcl90IGFkZHIsIGludCBzcnMpCiAJQlVHX09OKCFjcHVfaGFzX3ZlaWMgJiYgIWNwdV9oYXNf
dmludCk7CiAKIAlpZiAoYWRkciA9PSBOVUxMKSB7Ci0JCWhhbmRsZXIgPSAodW5zaWduZWQgbG9u
ZykgZG9fZGVmYXVsdF92aTsKKwkJc3dpdGNoKG4pIHsKKwkJY2FzZSA3OgorCQkJaGFuZGxlciA9
ICh1bnNpZ25lZCBsb25nKSBtaXBzX3RpbWVyX2Rpc3BhdGNoOworCQkJYnJlYWs7CisJCWRlZmF1
bHQ6CisJCQloYW5kbGVyID0gKHVuc2lnbmVkIGxvbmcpIGRvX2RlZmF1bHRfdmk7CisJCQlicmVh
azsKKwkJfQogCQlzcnMgPSAwOwogCX0gZWxzZQogCQloYW5kbGVyID0gKHVuc2lnbmVkIGxvbmcp
IGFkZHI7Cg==
--00163630ffe39c6af2049864c3f4--
