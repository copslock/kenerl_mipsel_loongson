Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Jan 2015 17:38:40 +0100 (CET)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:38297 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009651AbbAQQii6G6XG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Jan 2015 17:38:38 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id 233C45A6F66;
        Sat, 17 Jan 2015 18:38:29 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id wT0+3CXdSV-A; Sat, 17 Jan 2015 18:38:24 +0200 (EET)
Received: from fuloong-minipc (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with ESMTP id 4CDD35BC003;
        Sat, 17 Jan 2015 18:38:33 +0200 (EET)
Date:   Sat, 17 Jan 2015 18:38:32 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Matthew Fortune <Matthew.Fortune@imgtec.com>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>,
        Paul Burton <Paul.Burton@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: 3.18+: soft-float userland unusable due to .MIPS.abiflags patch
Message-ID: <20150117163832.GA12420@fuloong-minipc.musicnaut.iki.fi>
References: <CAOLZvyFP6FX3ydFdU7fmDd7GCnBCAPyLnxkmyjYknXP8Wui0kg@mail.gmail.com>
 <CAOLZvyGBOqCARmLx+rQ1CEgFw2TZBYYauGOiD9tF31MFsB-peQ@mail.gmail.com>
 <6D39441BF12EF246A7ABCE6654B0235320FA97DF@LEMAIL01.le.imgtec.org>
 <CAOLZvyGUGr3ubbzNjoFLCEDk29Fbn4qjoT6xmT=F1OZ4L-YhMA@mail.gmail.com>
 <CAOLZvyE7nk4r+gcYTkdbfeDWh6c75RRhijuh-XY=AK98LF81LA@mail.gmail.com>
 <6D39441BF12EF246A7ABCE6654B0235320FA9A04@LEMAIL01.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6D39441BF12EF246A7ABCE6654B0235320FA9A04@LEMAIL01.le.imgtec.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

On Fri, Jan 16, 2015 at 08:36:12PM +0000, Matthew Fortune wrote:
> You are right that it is the .MIPS.abiflags patch that is causing your
> trouble. For a long time I had to put a restriction in the ABI plan that
> soft-float binaries without an ABIFLAGS pheader could not be linked against
> soft-float binaries with an ABIFLAGS pheader. We have since found a way to
> relax that restriction without reducing the effectiveness of the new
> compatibility checks. I would need to check the code in the kernel but I 
> suspect that is the issue. Markos has done a significant update to this
> piece of code which he posted earlier today. That updated version should
> allow the combination of soft-float without ABIFLAGS and soft-float with
> ABIFLAGS.

Are you referring to the series with 70 patches? I think a fix that passes
stable kernel rules is needed.

A.
