Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Apr 2015 11:51:05 +0200 (CEST)
Received: from lb2-smtp-cloud2.xs4all.net ([194.109.24.25]:56046 "EHLO
        lb2-smtp-cloud2.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011046AbbDTJvD0AcOf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Apr 2015 11:51:03 +0200
Received: from [192.168.10.106] ([83.160.161.190])
        by smtp-cloud2.xs4all.net with ESMTP
        id J9qt1q00N46mmVf019quK2; Mon, 20 Apr 2015 11:50:56 +0200
Message-ID: <1429523456.14597.23.camel@x220>
Subject: Re: [PATCH 02/14] MIPS: ath79: Add basic device tree support
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Alban <albeu@free.fr>
Cc:     linux-mips@linux-mips.org, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 20 Apr 2015 11:50:56 +0200
In-Reply-To: <20150418183149.69c0795b@tock>
References: <1429280669-2986-1-git-send-email-albeu@free.fr>
         <1429280669-2986-3-git-send-email-albeu@free.fr>
         <1429340752.16771.120.camel@x220> <20150418183149.69c0795b@tock>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pebolle@tiscali.nl
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

On Sat, 2015-04-18 at 18:31 +0200, Alban wrote:
> On Sat, 18 Apr 2015 09:05:52 +0200
> Paul Bolle <pebolle@tiscali.nl> wrote:
> 
> > On Fri, 2015-04-17 at 16:24 +0200, Alban Bedel wrote:
> > 
> > > --- a/arch/mips/ath79/Kconfig
> > > +++ b/arch/mips/ath79/Kconfig
> > >  
> > > +choice
> > > +	prompt "Builtin devicetree selection"
> > > +	default DTB_ATH79_NONE
> > > +	help
> > > +	  Select the devicetree.
> > > +
> > > +	config DTB_ATH79_NONE
> > > +		bool "None"
> > > +endchoice
> > 
> > This adds a choice block with one config entry. So what this achieves
> > is that DTB_ATH79_NONE will always be 'y', right? Besides I didn't
> > notice on a user of CONFIG_DTB_ATH79_NONE. So as far as I can see
> > this choice has no effect on the build.
> > 
> > Why was this choice entry added?
> 
> This menu is for boards that need a built-in DTB, as MIPS currently
> doesn't support appended DTBs it is the only way to load a DTB on
> boards stuck with a broken boot loader. But as no board has been added
> yet it only contain the entry for boards that don't need a built-in
> DTB, which do nothing as you pointed out.
> 
> A board is then added in this menu in patch 14, for some reasons git
> send-email didn't send the whole serie at once :(

I saw 14/14 fly by now. (And I saw 12/12 of v2, which basically replaces
14/14.) That makes things clear.

Perhaps, if you're going to send a v3, you might move this change into
12/12. At least, I see little reason to add this choice block in two
separate steps in this series.

(Side note: you _might_ be able to drop config DTB_ATH79_NONE entirely
if you also replace
	default DTB_ATH79_NONE

with
	optional

optional is a little used option for choice blocks. I haven't tested
this, so this suggestion could end up wasting your time. And even then
this all looks like a complicated way to set just DTB_TL_WR1043ND_V1. I
suppose you expect to add things to this choice block in the future.)

Thanks,


Paul Bolle
