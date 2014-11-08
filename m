Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Nov 2014 12:36:34 +0100 (CET)
Received: from smtp5-g21.free.fr ([212.27.42.5]:54611 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012739AbaKHLgc1yBSb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 8 Nov 2014 12:36:32 +0100
Received: from tock (unknown [78.50.171.175])
        (Authenticated sender: albeu)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 3A364D48061;
        Sat,  8 Nov 2014 12:34:02 +0100 (CET)
Date:   Sat, 8 Nov 2014 12:36:25 +0100
From:   Alban <albeu@free.fr>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Aban Bedel <albeu@free.fr>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 1/2] MIPS: FW: Fix parsing u-boot environment
Message-ID: <20141108123625.5bf49656@tock>
In-Reply-To: <545CBE5E.3050906@cogentembedded.com>
References: <1415359381-27257-1-git-send-email-albeu@free.fr>
        <545CBE5E.3050906@cogentembedded.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43929
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

On Fri, 07 Nov 2014 15:43:10 +0300
Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> wrote:

> Hello.
> 
> On 11/7/2014 2:23 PM, Alban Bedel wrote:
> 
> > When reading u-boot's key=value pairs it should skip the '=' and not
> > use the next argument.
> 
> > Signed-off-by: Alban Bedel <albeu@free.fr>
> > ---
> >   arch/mips/fw/lib/cmdline.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> > diff --git a/arch/mips/fw/lib/cmdline.c b/arch/mips/fw/lib/cmdline.c
> > index ffd0345..cc5d168 100644
> > --- a/arch/mips/fw/lib/cmdline.c
> > +++ b/arch/mips/fw/lib/cmdline.c
> > @@ -68,7 +68,7 @@ char *fw_getenv(char *envname)
> >   					result = fw_envp(index +
> > 1); break;
> >   				} else if (fw_envp(index)[i] ==
> > '=') {
> > -					result = (fw_envp(index +
> > 1) + i);
> > +					result = (fw_envp(index) +
> > i + 1);
> 
>     Perhaps it's time to drop the useless outer parens?

I agree, I'm sending a new serie.

Alban
