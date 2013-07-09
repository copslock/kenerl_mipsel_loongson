Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Jul 2013 18:00:51 +0200 (CEST)
Received: from mail-we0-f177.google.com ([74.125.82.177]:39639 "EHLO
        mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835062Ab3GIP50qCLe8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Jul 2013 17:57:26 +0200
Received: by mail-we0-f177.google.com with SMTP id m19so4882509wev.36
        for <multiple recipients>; Tue, 09 Jul 2013 08:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=q0ZrjRVC7hPJCfYOMoGy8oJxB+9d3t5ADCJ5Kzc+j1k=;
        b=Kqjctxjfm7Cf/ykFmlalqpNPpbf/81OGydJzGhm+vMsWa9bY/cYKBoA/2ZG+cctxwF
         We17WLVag/uVTXPffNxZq7HBxEsNJvSj8okWdXb0fiCfeYfSUE6oN97KIPLiGWBZNUop
         RUs8yykS7stHsStPyRw2VcJWr25Zvuv5mF0+iKYigX7DdLTRggER40Tr0cHgFyC6atd2
         ftJsmNqDWGoHHeCkxcwZm4juv6aU8hwDnzPBldHJhhlb2nzU3V37v9C6GRmESmtjtu2t
         E1BEjFWses0Ho8F67R0BGv6QwLHamlamSf3n5hIGv0s9gvVi4z8ID6/0TH7X43VYPkUg
         28Ig==
MIME-Version: 1.0
X-Received: by 10.194.119.228 with SMTP id kx4mr15311696wjb.33.1373385441392;
 Tue, 09 Jul 2013 08:57:21 -0700 (PDT)
Received: by 10.194.1.131 with HTTP; Tue, 9 Jul 2013 08:57:21 -0700 (PDT)
In-Reply-To: <20130627144707.GE10727@linux-mips.org>
References: <20130627143439.GD10727@linux-mips.org>
        <20130627144707.GE10727@linux-mips.org>
Date:   Tue, 9 Jul 2013 09:57:21 -0600
Message-ID: <CACoURw6Z7_SdXUfnqqmxur9mQHoVmD8bD1ut7eGAtGafBCujUA@mail.gmail.com>
Subject: Re: Pending PMC-Sierra MSP patches
From:   Shane McDonald <mcdonald.shane@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Adam Kiepul <Adam_Kiepul@pmc-sierra.com>,
        "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
Content-Type: multipart/alternative; boundary=089e012292e25fc4ed04e1163719
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37280
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
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

--089e012292e25fc4ed04e1163719
Content-Type: text/plain; charset=ISO-8859-1

On Thursday, June 27, 2013, Ralf Baechle wrote:

> Resendig with a few people who might be interested (or know somebody
> who might be) added to cc.
>
> On Thu, Jun 27, 2013 at 04:34:39PM +0200, Ralf Baechle wrote:
> > There is still a fair number of patches for the PMC-Sierra MSP series
> > of platforms pending.  Those patches being over two years old are
> > fairly stale by now so I wonder if somebody with interest in the
> > platform could review, respin and test the patches?
> >
> > The patches in question are can be found in patchwork at
> >
> >
> http://patchwork.linux-mips.org/project/linux-mips/list/?submitter=413&archive=true
>
>   Ralf
>

I've forwarded this email on to internal contacts at PMC-Sierra, but it
appears there is little PMC activity on this platform. Feel free to drop
the patches; if I find a need for them, I can respin and resubmit.

Shane

--089e012292e25fc4ed04e1163719
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div><br>On Thursday, June 27, 2013, Ralf Baechle  wrote:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">Resendig with a few people who might be interested (or=
 know somebody<br>

who might be) added to cc.<br>
<br>
On Thu, Jun 27, 2013 at 04:34:39PM +0200, Ralf Baechle wrote:<br>
&gt; There is still a fair number of patches for the PMC-Sierra MSP series<=
br>
&gt; of platforms pending. =A0Those patches being over two years old are<br=
>
&gt; fairly stale by now so I wonder if somebody with interest in the<br>
&gt; platform could review, respin and test the patches?<br>
&gt;<br>
&gt; The patches in question are can be found in patchwork at<br>
&gt;<br>
&gt; =A0 =A0<a href=3D"http://patchwork.linux-mips.org/project/linux-mips/l=
ist/?submitter=3D413&amp;archive=3Dtrue" target=3D"_blank">http://patchwork=
.linux-mips.org/project/linux-mips/list/?submitter=3D413&amp;archive=3Dtrue=
</a><br>
<br>
=A0 Ralf<br>
</blockquote><div><br></div><div>I&#39;ve forwarded this email on to intern=
al contacts at PMC-Sierra, but it appears there is little PMC<span></span>=
=A0activity on this platform. Feel free to drop the patches; if I find a ne=
ed for them, I can respin and resubmit.</div>
<div><br></div><div>Shane=A0</div></div>

--089e012292e25fc4ed04e1163719--
