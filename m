Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Mar 2009 08:43:20 +0000 (GMT)
Received: from wf-out-1314.google.com ([209.85.200.168]:59343 "EHLO
	wf-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20808938AbZCIInQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Mar 2009 08:43:16 +0000
Received: by wf-out-1314.google.com with SMTP id 25so1872562wfc.21
        for <linux-mips@linux-mips.org>; Mon, 09 Mar 2009 01:43:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=JhXvzy/T3mprdjjxu/gsoG3hADereAPslUNIibhga/Y=;
        b=v/DPsZqY3syaGv2aUhW/cmP3SLruLZGZIBm9xH8HwkCXglYrTXOf4AIXRW032FsiiD
         Afgtzfs9GR6wIdo+gkz0ZcF7dWj8uKNKWlmYZQUHi+fClKMOjFxJ27lcKr/5iSVQCeE5
         UQji+GjLE7PsiFmds2Exz5nrdUEJhuAtQmFjU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=h51o928/9B6RPpAI0QsL2ulJFzw+Czy4f+CDx5F2b5sf3DIBiGDjLRwRfTCzvz4Vds
         Tzxx6SGx2PY9G/JM8sJFAhL3sWR1HF/otILYjpz0JjCbCNYC/Bvkt45Hd00gXpR73QcS
         AYvuJFDhQ7VVI31n6Ug92m/q3hBt3dyxDbk8s=
MIME-Version: 1.0
Received: by 10.143.18.21 with SMTP id v21mr2446745wfi.149.1236588194401; Mon, 
	09 Mar 2009 01:43:14 -0700 (PDT)
In-Reply-To: <1236282218.49b02b6a6c724@imp.free.fr>
References: <1236282218.49b02b6a6c724@imp.free.fr>
Date:	Mon, 9 Mar 2009 16:43:14 +0800
Message-ID: <5a350f0f0903090143l432f80f4i9663637153b12f87@mail.gmail.com>
Subject: Re: gns mips-l: what next?
From:	Arthur WebKid <arthur.webkid@gmail.com>
To:	s.boutayeb@free.fr
Cc:	gnewsense-dev@nongnu.org, dclark@gnu.org, rms@gnu.org,
	debian-mips@lists.debian.org, linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=0016368e21900f8ea50464aba009
Return-Path: <arthur.webkid@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22044
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arthur.webkid@gmail.com
Precedence: bulk
X-list: linux-mips

--0016368e21900f8ea50464aba009
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi

It is really a good news for free software/hardware advocates!

What is in my mind is promotion of the concept of free software + hardware,
with Lemote mini-box and laptops in the Internet, (maybe at FSF recommended
hardware?).

The more people using Lemote hardware, the more chance they understand their
need of freedom, the more they choose gNewSense, the more hackers /
developers/ resources we (the gNewSense team) can get.

Cheers!!

--
Arthur Webkid

2009/3/6 <s.boutayeb@free.fr>

> Hi,
>
> The "gNewSense mips-l" project (
> http://wiki.gnewsense.org/Projects/GNewSenseToMIPS ) is on a good way,
> thanks to
> the support of the gNewSense team, of the FSF, of Lemote Tech, and of
> various
> contributors around the world.
>
> So far, we have a gNewSense-compliant Debian installer allowing the
> execution of
> netboot installation procedure from an usb stick and fine-tuned for the
> lemote
> hardware. The installation and the upgrade uses the archive set by the FSF
> at
> http://archive.gnewsense.org/gnewsense-mipsel-l/.
>
> The Lemote hardware ("yeeloong 8089" laptop and "Fuloong 6003" mini box)
> boot
> from the bsd licensed PMON200 boot loader.
>
> The netboot install procedure has be proven successful on the "Yeeloong
> 8089"
> laptop and remains to be tested on the "Fuloong 6003" mini box. We have now
> a
> nice full-free laptop with beautiful arts designed by the
> gNewSense-arts-team, a
> working gnome desktop environment. Many things need to be polished: for
> example
> the apm (the battery of the laptops show a 0% gauge), the webcam is not yet
> working), but we have full networking capabilities (both wired and
> wireless), a
> functional xorg server (thanks to the siliconmotion driver from lemote's
> dev),
> etc.
>
> In the same time, Lemote Tech's team has setup a netboot installation
> procedure
> http://dev.lemote.com/drupal/node/58 and has provided valuable advice,
> hardware
> resources, code, etc. to the gNewSenseToMips project. This was a big help
> for us
> all.
>
> Now, how could we move forward? Maybe:
> - improving
> - testing
> - documenting
> - upgrading
> - promoting
> - upstreaming
> - etc.
>
> That is, many things, but not too much, considering the realistic
> perspective
> that more talents decide to contribute to the gNewSense project. You are
> wellcome!
>
> Thank you for your comments and for your support!
>
> Cheers
>
> Samy
>
>
> --
> To UNSUBSCRIBE, email to debian-mips-REQUEST@lists.debian.org
> with a subject of "unsubscribe". Trouble? Contact
> listmaster@lists.debian.org
>
>

--0016368e21900f8ea50464aba009
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi</div>
<div>=A0</div>
<div>It is really a good news for free software/hardware advocates!</div>
<div>=A0</div>
<div>What is in my mind is promotion of the concept of free software + hard=
ware, with Lemote mini-box and laptops in the Internet, (maybe at FSF recom=
mended hardware?).</div>
<div>=A0</div>
<div>The more people using Lemote hardware, the more chance they understand=
 their need of freedom, the more they choose gNewSense, the more hackers / =
developers/ resources we (the gNewSense team) can get.</div>
<div>=A0</div>
<div>Cheers!!</div>
<div>=A0</div>
<div>--</div>
<div>Arthur Webkid<br><br></div>
<div class=3D"gmail_quote">2009/3/6 <span dir=3D"ltr">&lt;<a href=3D"mailto=
:s.boutayeb@free.fr">s.boutayeb@free.fr</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi,<br><br>The &quot;gNewSense m=
ips-l&quot; project (<br><a href=3D"http://wiki.gnewsense.org/Projects/GNew=
SenseToMIPS" target=3D"_blank">http://wiki.gnewsense.org/Projects/GNewSense=
ToMIPS</a> ) is on a good way, thanks to<br>
the support of the gNewSense team, of the FSF, of Lemote Tech, and of vario=
us<br>contributors around the world.<br><br>So far, we have a gNewSense-com=
pliant Debian installer allowing the execution of<br>netboot installation p=
rocedure from an usb stick and fine-tuned for the lemote<br>
hardware. The installation and the upgrade uses the archive set by the FSF =
at<br><a href=3D"http://archive.gnewsense.org/gnewsense-mipsel-l/" target=
=3D"_blank">http://archive.gnewsense.org/gnewsense-mipsel-l/</a>.<br><br>Th=
e Lemote hardware (&quot;yeeloong 8089&quot; laptop and &quot;Fuloong 6003&=
quot; mini box) boot<br>
from the bsd licensed PMON200 boot loader.<br><br>The netboot install proce=
dure has be proven successful on the &quot;Yeeloong 8089&quot;<br>laptop an=
d remains to be tested on the &quot;Fuloong 6003&quot; mini box. We have no=
w a<br>
nice full-free laptop with beautiful arts designed by the gNewSense-arts-te=
am, a<br>working gnome desktop environment. Many things need to be polished=
: for example<br>the apm (the battery of the laptops show a 0% gauge), the =
webcam is not yet<br>
working), but we have full networking capabilities (both wired and wireless=
), a<br>functional xorg server (thanks to the siliconmotion driver from lem=
ote&#39;s dev),<br>etc.<br><br>In the same time, Lemote Tech&#39;s team has=
 setup a netboot installation procedure<br>
<a href=3D"http://dev.lemote.com/drupal/node/58" target=3D"_blank">http://d=
ev.lemote.com/drupal/node/58</a> and has provided valuable advice, hardware=
<br>resources, code, etc. to the gNewSenseToMips project. This was a big he=
lp for us<br>
all.<br><br>Now, how could we move forward? Maybe:<br>- improving<br>- test=
ing<br>- documenting<br>- upgrading<br>- promoting<br>- upstreaming<br>- et=
c.<br><br>That is, many things, but not too much, considering the realistic=
 perspective<br>
that more talents decide to contribute to the gNewSense project. You are<br=
>wellcome!<br><br>Thank you for your comments and for your support!<br><br>=
Cheers<br><br>Samy<br><font color=3D"#888888"><br><br>--<br>To UNSUBSCRIBE,=
 email to <a href=3D"mailto:debian-mips-REQUEST@lists.debian.org">debian-mi=
ps-REQUEST@lists.debian.org</a><br>
with a subject of &quot;unsubscribe&quot;. Trouble? Contact <a href=3D"mail=
to:listmaster@lists.debian.org">listmaster@lists.debian.org</a><br><br></fo=
nt></blockquote></div><br>

--0016368e21900f8ea50464aba009--
