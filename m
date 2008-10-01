Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Oct 2008 19:37:04 +0100 (BST)
Received: from ey-out-1920.google.com ([74.125.78.146]:8900 "EHLO
	ey-out-1920.google.com") by ftp.linux-mips.org with ESMTP
	id S20285079AbYJAShC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Oct 2008 19:37:02 +0100
Received: by ey-out-1920.google.com with SMTP id 4so292674eyg.54
        for <linux-mips@linux-mips.org>; Wed, 01 Oct 2008 11:37:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:reply-to:organization:to
         :subject:date:user-agent:references:in-reply-to:x-face:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        bh=bpmTQv5z4OrhuZOyM53N/kaxKvTgeLut85Q5269TGXk=;
        b=LZ1CPICTBq8Et+gQ5pY/UAZPV5AHVCxxYQ93L4jPdw5cB6Gp+NLHqfzqV9lHV2kOHk
         MaGtul2v520jew1N2wQ7TPJu66nWwy4Qk3lLCTQNBO6Mu7IgXMf8g5H7UBW0cugwot/X
         lbcV4LCH/0rkrStv0jt5u36axrxjIacfWu/xs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:reply-to:organization:to:subject:date:user-agent:references
         :in-reply-to:x-face:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=vqzzq+6+oWaf3jkNj6WNY6B1/T/E27u6R5gikp53QsQodjamYg/EDH9Z8KEIxAlcgR
         gLlEAaBOWO5IdKv8syrZQ6ju4TA7rNQLDNCcwEBX3ALRtPper4yI6uzktN4fOuo+NMcF
         4M1wkBKqlPdk0rIBd0VhlsG0lc7bv4kzwa+qM=
Received: by 10.86.72.3 with SMTP id u3mr7571827fga.62.1222886221549;
        Wed, 01 Oct 2008 11:37:01 -0700 (PDT)
Received: from cartesio.localnet (host250-108-static.46-85-b.business.telecomitalia.it [85.46.108.250])
        by mx.google.com with ESMTPS id l19sm441fgb.7.2008.10.01.11.36.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Oct 2008 11:36:30 -0700 (PDT)
From:	"Luigi 'Comio' Mantellini" <luigi.mantellini.ml@gmail.com>
Reply-To: luigi.mantellini.ml@gmail.com
Organization: Industrie Dial Face S.p.A.
To:	linux-mips@linux-mips.org
Subject: Re: page_write_back infinite wait (porting to Mips 4kec SoC)
Date:	Wed, 1 Oct 2008 20:36:26 +0200
User-Agent: KMail/1.10.1 (Linux/2.6.24-21-generic; KDE/4.1.1; i686; ; )
References: <200809231409.44987.luigi.mantellini.ml@gmail.com>
In-Reply-To: <200809231409.44987.luigi.mantellini.ml@gmail.com>
X-Face:	'6!%DGk.Oa/l`>tHr&^29|<`2s/|PIbM@0,\4g%@-F7xr9V,K@Iu<A>G-jQ\T_t@
 =?utf-8?q?ZM5UC7=0A=09=2El0=5C=2Enz=5B=3D=24C9=5E=60vJt=3BP=3DZRBk2+x+pB?=)\8;"bA3>@
 =?utf-8?q?5aI66l5Xfw*X8=23+kcy1ybOBUNMnc=3Bs=0A=09UXb=5C=26=5D+8*bloRi?=<euepX(,
 =?utf-8?q?esSS=5C=7D3j=7CoU=7C=5FXku72+-=3FC0miI=7Da=5E=7E=24j-O-/ELA-gTX/?=
 =?utf-8?q?IVUi=0A=09=25fmY6?=(!tfc}&,mzme<IwkA;^CKV:vIY</xKrN8F6`X~EPI#-B4*e"I;edO
MIME-Version: 1.0
Content-Type: multipart/alternative;
  boundary="Boundary-00=_rM84ISNcLG90xfy"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200810012036.27034.luigi.mantellini.ml@gmail.com>
Return-Path: <luigi.mantellini.ml@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20671
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luigi.mantellini.ml@gmail.com
Precedence: bulk
X-list: linux-mips

--Boundary-00=_rM84ISNcLG90xfy
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I discovered the trouble...

the bsp code (from my cpu vendor) wrongly writes out the irq_desc vector=20
overwriting some vital kernel structure...

best regards,

luigi
  =20

Il marted=EC 23 settembre 2008 14:09:44 Luigi 'Comio' Mantellini ha scritto:
> Hi List,
>
> I'm working on a 4Kec SoC. I'm trying to port a recent kernel (2.6.26-rcX
> from trunk) to my SoC but I have problem on timers (i think).
>
> The start sequence (start_kernel @init/main.c) freezes on the
> page_writeback_init() call. The page_writeback_init function calls the
> lock_timer_base function (by means the mod_timer/__mod_timer) that fails
> always the test likely(base!=3DNULL) (source file kernel/timer.c). The ba=
se
> variable (ponter to tvec_base) is always NULL, resulting an infinite loop.
>
> I'm using the cevt-r4t and csrc-4k standard mips 4k timer (on irq #7). Wi=
th
> debugger I verified that the c0_compare_interrupt service routine is
> correctly invoked.
>
> Kindly, can anyone help me to understand what I need to check to solve th=
is
> issue? If you need other information, please, ask me (This is my first mi=
ps
> port).
>
> Thanks in advance.
>
> best regards.
>
> luigi

=2D-=20
Luigi Mantellini
R&D - Software
Industrie Dial Face S.p.A.
Via Canzo, 4
20068 Peschiera Borromeo (MI), Italy
Tel.:  +39 02 5167 2813
=46ax:   +39 02 5167 2459
Email: luigi.mantellini@idf-hit.com


--Boundary-00=_rM84ISNcLG90xfy
Content-Type: text/html;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-=
html40/strict.dtd">
<html><head><meta name=3D"qrichtext" content=3D"1" /><style type=3D"text/cs=
s">
p, li { white-space: pre-wrap; }
</style></head><body style=3D" font-family:'DejaVu Sans'; font-size:10pt; f=
ont-weight:400; font-style:normal;">
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">I discovere=
d the trouble...</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">the bsp cod=
e (from my cpu vendor) wrongly writes out the irq_desc vector overwriting s=
ome vital kernel structure...</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">best regard=
s,</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">luigi</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">   </p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Il marted=
=EC 23 settembre 2008 14:09:44 Luigi 'Comio' Mantellini ha scritto:</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; Hi Lis=
t,</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; I'm wo=
rking on a 4Kec SoC. I'm trying to port a recent kernel (2.6.26-rcX</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; from t=
runk) to my SoC but I have problem on timers (i think).</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; The st=
art sequence (start_kernel @init/main.c) freezes on the</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; page_w=
riteback_init() call. The page_writeback_init function calls the</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; lock_t=
imer_base function (by means the mod_timer/__mod_timer) that fails</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; always=
 the test likely(base!=3DNULL) (source file kernel/timer.c). The base</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; variab=
le (ponter to tvec_base) is always NULL, resulting an infinite loop.</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; I'm us=
ing the cevt-r4t and csrc-4k standard mips 4k timer (on irq #7). With</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; debugg=
er I verified that the c0_compare_interrupt service routine is</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; correc=
tly invoked.</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; Kindly=
, can anyone help me to understand what I need to check to solve this</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; issue?=
 If you need other information, please, ask me (This is my first mips</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; port).=
</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; Thanks=
 in advance.</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; best r=
egards.</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; luigi<=
/p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">-- </p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Luigi Mante=
llini</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">R&amp;D - S=
oftware</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Industrie D=
ial Face S.p.A.</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Via Canzo, =
4</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">20068 Pesch=
iera Borromeo (MI), Italy</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Tel.:  +39 =
02 5167 2813</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Fax:   +39 =
02 5167 2459</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-rig=
ht:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Email: luig=
i.mantellini@idf-hit.com</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"></p></body></html>
--Boundary-00=_rM84ISNcLG90xfy--
