Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Apr 2009 02:09:43 +0100 (BST)
Received: from mail-qy0-f171.google.com ([209.85.221.171]:54393 "EHLO
	mail-qy0-f171.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20021326AbZD2BJg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 29 Apr 2009 02:09:36 +0100
Received: by qyk1 with SMTP id 1so1864605qyk.22
        for <linux-mips@linux-mips.org>; Tue, 28 Apr 2009 18:09:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=dBmKB7/Nn8rvDf2qURvxpfEhqhlU9J+pcFW2Ch2ICR8=;
        b=csxr+BZPjkpAk/5BYQqPRRx3qXkZsK5YTSKrX04YsvWLdDleGnvFCnjKpN8DBjfbQH
         C3MZectph+6XAnJGeB3I6xLfj1VDcpfq+d/qYlFBVubwILmLGTZnHDeUjuHbxfyr7zpR
         vAerVxzIZ7gj5lU6+FNWeBwcTJoENNUjoSBHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=J0sTiaqQmfXWcDb8SGg/HwBjHiaZ32pMbUnq9rDCNZBgTtm6vo8kfWDTpfbePlKFnc
         xpK5IJWtVW4Ds5KAYbtnek1pVlNMd+M05AQMOys4NyFmhDdh81Q8b+FeyFRRf/KC53Fe
         08RUSJR8ytprhnKmxkQdTmJ8EibVId1xHWu18=
MIME-Version: 1.0
Received: by 10.220.44.197 with SMTP id b5mr14175772vcf.114.1240967369277; 
	Tue, 28 Apr 2009 18:09:29 -0700 (PDT)
In-Reply-To: <ecbbfeda0904281805l21118b94uf7889df3171b4ba7@mail.gmail.com>
References: <ecbbfeda0904280458s4bb2de2q6c629ed79a472adc@mail.gmail.com>
	 <200904281501.37811.florian@openwrt.org>
	 <ecbbfeda0904281012h33f3a572nbd11547d5964c19d@mail.gmail.com>
	 <49F749FE.8050808@wp.pl> <49F74BE9.30004@wp.pl>
	 <ecbbfeda0904281805l21118b94uf7889df3171b4ba7@mail.gmail.com>
Date:	Tue, 28 Apr 2009 20:09:29 -0500
Message-ID: <ecbbfeda0904281809v777cda0er38836129ff14a803@mail.gmail.com>
Subject: Re: Linux on Linksys PSUS4?
From:	Andrew Wiley <debio264@gmail.com>
To:	linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=0016e6464f723942e10468a73b6a
Return-Path: <debio264@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22530
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: debio264@gmail.com
Precedence: bulk
X-list: linux-mips

--0016e6464f723942e10468a73b6a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

> Forgot: squidge has approx 800kB footprint (kernel+drivers, rootfs on
> USB stick). You may try to load it on your device. (but don't know if
> 2.6 kernel will work on 4M RAM).


I'm not sure how much of a difference there is between hardware that has
this processor. Can I just use the latest version of Squidge, or do I need
to look through kernel settings and recompile it?
Can I just use linksys-tftp to load the Squidge firmware in?

>
>
> W.P.
>
>

--0016e6464f723942e10468a73b6a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><div class=3D"gmail_quote"><div class=3D"im"><br=
><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204,=
 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Forgot: squidge =
has approx 800kB footprint (kernel+drivers, rootfs on<br>


USB stick). You may try to load it on your device. (but don&#39;t know if<b=
r>
2.6 kernel will work on 4M RAM).</blockquote></div><div><br>I&#39;m not sur=
e how much of a difference there is between hardware that has this processo=
r. Can I just use the latest version of Squidge, or do I need to look throu=
gh kernel settings and recompile it?<br>

Can I just use linksys-tftp to load the Squidge firmware in? <br></div><blo=
ckquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204,=
 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<font color=3D"#888888"><br>
W.P.<br>
<br>
</font></blockquote></div>
</div><br>

--0016e6464f723942e10468a73b6a--
