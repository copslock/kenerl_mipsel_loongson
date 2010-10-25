Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Oct 2010 22:25:14 +0200 (CEST)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:35615 "EHLO
        hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491113Ab0JYUZJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Oct 2010 22:25:09 +0200
X-Authority-Analysis: v=1.1 cv=NFUeGz0loTdi/T6hXKngYYtckjed7x3pKvNOqmBBK18= c=1 sm=0 a=z3AvDWF0GpkA:10 a=Q9fys5e9bTEA:10 a=OPBmh+XkhLl+Enan7BmTLg==:17 a=SyI_GHdlAAAA:8 a=ULv1lsJp_flTOsgAmH0A:9 a=9fi9rVhrr64fEmwemfBC0NPNmSsA:4 a=PUjeQqilurYA:10 a=UQxMgyrMzRwA:10 a=OPBmh+XkhLl+Enan7BmTLg==:117
X-Cloudmark-Score: 0
X-Originating-IP: 67.242.120.143
Received: from [67.242.120.143] ([67.242.120.143:55337] helo=[192.168.23.10])
        by hrndva-oedge04.mail.rr.com (envelope-from <rostedt@goodmis.org>)
        (ecelerity 2.2.3.46 r()) with ESMTP
        id A3/51-12606-697E5CC4; Mon, 25 Oct 2010 20:24:55 +0000
Subject: Re: patch v2: [RFC 2/2] ftrace/MIPS: Add support for C version of
 recordmcount
From:   Steven Rostedt <rostedt@goodmis.org>
To:     wu zhangjin <wuzhangjin@gmail.com>
Cc:     John Reiser <jreiser@bitwagon.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
In-Reply-To: <AANLkTin=ym_e8009pHkn+7jtXG1toiKb1O3TS4FNQu3U@mail.gmail.com>
References: <AANLkTinwXjLAYACUfhLYaocHD_vBbiErLN3NjwN8JqSy@mail.gmail.com>
         <4CC49A99.1080601@bitwagon.com>
         <alpine.LFD.2.00.1010250435540.15889@eddie.linux-mips.org>
         <4CC5B474.9050503@bitwagon.com>
         <AANLkTin=ym_e8009pHkn+7jtXG1toiKb1O3TS4FNQu3U@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Mon, 25 Oct 2010 16:24:54 -0400
Message-ID: <1288038294.18238.4.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

On Tue, 2010-10-26 at 02:17 +0800, wu zhangjin wrote:
> On 10/26/10, John Reiser <jreiser@bitwagon.com> wrote:
> > Here's a second try [discard the first] for handling MIPS64 in
> > recordmcount.[ch].
> 
> Just tested the 64bit kernel, it works well.
> 
> Will test the 64bit module and the 32bit kernel and module tomorrow If
> time allowed.
> 
> BTW, seems this patch can not be applied directly, suggest you
> generate it by "git format" automatically ;-)


Great! If it all passes nicely, can I get a tested-by from you, and a
patch that enables it for mips with an Acked-by: from Ralf?

We may still be able to make this merge window.

-- Steve
