Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Dec 2014 03:48:05 +0100 (CET)
Received: from mail-qc0-f181.google.com ([209.85.216.181]:51262 "EHLO
        mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008814AbaLVCsEBxZI0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Dec 2014 03:48:04 +0100
Received: by mail-qc0-f181.google.com with SMTP id m20so2828639qcx.26;
        Sun, 21 Dec 2014 18:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Mks9noxzfE1AlTn9Ht048F7dpvkqrGLDtdaGv7TQtAo=;
        b=tPZQI1wXNCdEuGvi2iqIUwjlgcwU6erjbkp/m1Ss28eLme5DaPQLWx25w7g2MILsLj
         iwvZqUJZhrZXqdqa9lXao2fcNZxMaeNbJhnuGFwSzODVJN5Puv80aN4RerBqDrVgjGQM
         l5V1kM0RBj9+c/tmMF4VBr1qA/C8T4pcld/YTEpYBkxEY+hwStCFepr6DLd5pGZFWHIc
         guQ9esdR7vzB51+mmhDQoAM177sfHrlE81dw5LnvlWVr3apNYampC9fTQvlabYg7IjRm
         ZAJOQHqCv9x2S12nE5q9R2gx3y3RRm5aNc6PGLkKzI9YuhokiW4O+9xyvn7Lmvz6Hgav
         KW6Q==
MIME-Version: 1.0
X-Received: by 10.140.83.169 with SMTP id j38mr30585108qgd.99.1419216478170;
 Sun, 21 Dec 2014 18:47:58 -0800 (PST)
Received: by 10.140.22.81 with HTTP; Sun, 21 Dec 2014 18:47:58 -0800 (PST)
In-Reply-To: <CAJiQ=7AHKaFPe+UXSKphSrsQ6J9Fagaou6FZRE+deigeqwHjxw@mail.gmail.com>
References: <1418985621-4210-1-git-send-email-jaedon.shin@gmail.com>
        <CAGVrzcYaKF2M_pZTvB6kGM2czrTQq2KhV1BTKb0VkQivjMsNxg@mail.gmail.com>
        <CAJiQ=7AHKaFPe+UXSKphSrsQ6J9Fagaou6FZRE+deigeqwHjxw@mail.gmail.com>
Date:   Mon, 22 Dec 2014 11:47:58 +0900
Message-ID: <CABHeg8swSW5T5cj2P_3W63CRk2TOVjRmP_YSGiMidDGSMH6XwQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: BMIPS: fix overwriting without setting the bit
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: multipart/alternative; boundary=001a11c131060a791e050ac5167e
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44890
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

--001a11c131060a791e050ac5167e
Content-Type: text/plain; charset=UTF-8

2014-12-22 2:02 GMT+09:00 Kevin Cernekee <cernekee@gmail.com>:

> On Sun, Dec 21, 2014 at 2:41 AM, Florian Fainelli <f.fainelli@gmail.com>
> wrote:
> > 2014-12-19 2:40 GMT-08:00 Jaedon Shin <jaedon.shin@gmail.com>:
> >> To flush to readahead cache, set 8th bit in the RAC_CONFIG.
> >>
> >> The previous commit "MIPS: BMIPS: Flush the readahead cache after DMA"
> >> has a problem overwriting to the original other configuration values.
> >
> > Right, after the the first write we would basically disable the RAC
> entirely.
> >
> >>
> >> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> >
> > Acked-by: Florian Fainelli <f.fainelli@gmail.com>
>
> This looks fine to me, but I am not sure if any of Ralf's trees
> actually contain my buggy commit yet.  Which branch did you use as a
> baseline?
>
> Anyway:
>
> Acked-by: Kevin Cernekee <cernekee@gmail.com>
>

I was mistaken. Not the content in the Ralf's trees.
I'll wait until the next Cernekee's BMIPS commits.

And, pleases note the following about the BCM7358 and BCM7362
https://github.com/jaedon/linux/tree/bmips/brcmstb-v1

--001a11c131060a791e050ac5167e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-family:arial,sans-serif">2014-12-22 2:=
02 GMT+09:00 Kevin Cernekee </span><span dir=3D"ltr">&lt;<a href=3D"mailto:=
cernekee@gmail.com" target=3D"_blank">cernekee@gmail.com</a>&gt;</span><spa=
n style=3D"font-family:arial,sans-serif">:</span><br><div class=3D"gmail_ex=
tra"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,20=
4,204);border-left-style:solid;padding-left:1ex"><span class=3D"">On Sun, D=
ec 21, 2014 at 2:41 AM, Florian Fainelli &lt;<a href=3D"mailto:f.fainelli@g=
mail.com">f.fainelli@gmail.com</a>&gt; wrote:<br>
&gt; 2014-12-19 2:40 GMT-08:00 Jaedon Shin &lt;<a href=3D"mailto:jaedon.shi=
n@gmail.com">jaedon.shin@gmail.com</a>&gt;:<br>
&gt;&gt; To flush to readahead cache, set 8th bit in the RAC_CONFIG.<br>
&gt;&gt;<br>
&gt;&gt; The previous commit &quot;MIPS: BMIPS: Flush the readahead cache a=
fter DMA&quot;<br>
&gt;&gt; has a problem overwriting to the original other configuration valu=
es.<br>
&gt;<br>
&gt; Right, after the the first write we would basically disable the RAC en=
tirely.<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Jaedon Shin &lt;<a href=3D"mailto:jaedon.shin@gmail=
.com">jaedon.shin@gmail.com</a>&gt;<br>
&gt;<br>
&gt; Acked-by: Florian Fainelli &lt;<a href=3D"mailto:f.fainelli@gmail.com"=
>f.fainelli@gmail.com</a>&gt;<br>
<br>
</span>This looks fine to me, but I am not sure if any of Ralf&#39;s trees<=
br>
actually contain my buggy commit yet.=C2=A0 Which branch did you use as a<b=
r>
baseline?<br>
<br>
Anyway:<br>
<br>
Acked-by: Kevin Cernekee &lt;<a href=3D"mailto:cernekee@gmail.com">cernekee=
@gmail.com</a>&gt;<br>
</blockquote></div><br></div><div class=3D"gmail_extra">I was mistaken. Not=
 the content in the Ralf&#39;s trees.</div><div class=3D"gmail_extra">I&#39=
;ll wait until the next=C2=A0Cernekee&#39;s BMIPS commits.</div><div class=
=3D"gmail_extra"><br></div><div class=3D"gmail_extra">And, pleases note the=
 following about the BCM7358 and BCM7362</div><div class=3D"gmail_extra"><a=
 href=3D"https://github.com/jaedon/linux/tree/bmips/brcmstb-v1">https://git=
hub.com/jaedon/linux/tree/bmips/brcmstb-v1</a></div></div>

--001a11c131060a791e050ac5167e--
