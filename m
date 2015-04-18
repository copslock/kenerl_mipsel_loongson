Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Apr 2015 18:32:10 +0200 (CEST)
Received: from smtp1-g21.free.fr ([212.27.42.1]:2760 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007793AbbDRQcI4WZjm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 18 Apr 2015 18:32:08 +0200
Received: from tock (unknown [80.171.212.207])
        (Authenticated sender: albeu)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id 110B59400B3;
        Sat, 18 Apr 2015 18:29:40 +0200 (CEST)
Date:   Sat, 18 Apr 2015 18:31:49 +0200
From:   Alban <albeu@free.fr>
To:     Paul Bolle <pebolle@tiscali.nl>
Cc:     Aban Bedel <albeu@free.fr>, linux-mips@linux-mips.org,
        Rob Herring <robh+dt@kernel.org>,
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
Subject: Re: [PATCH 02/14] MIPS: ath79: Add basic device tree support
Message-ID: <20150418183149.69c0795b@tock>
In-Reply-To: <1429340752.16771.120.camel@x220>
References: <1429280669-2986-1-git-send-email-albeu@free.fr>
        <1429280669-2986-3-git-send-email-albeu@free.fr>
        <1429340752.16771.120.camel@x220>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46910
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

On Sat, 18 Apr 2015 09:05:52 +0200
Paul Bolle <pebolle@tiscali.nl> wrote:

> On Fri, 2015-04-17 at 16:24 +0200, Alban Bedel wrote:
> 
> > --- a/arch/mips/ath79/Kconfig
> > +++ b/arch/mips/ath79/Kconfig
> >  
> > +choice
> > +	prompt "Builtin devicetree selection"
> > +	default DTB_ATH79_NONE
> > +	help
> > +	  Select the devicetree.
> > +
> > +	config DTB_ATH79_NONE
> > +		bool "None"
> > +endchoice
> 
> This adds a choice block with one config entry. So what this achieves
> is that DTB_ATH79_NONE will always be 'y', right? Besides I didn't
> notice on a user of CONFIG_DTB_ATH79_NONE. So as far as I can see
> this choice has no effect on the build.
> 
> Why was this choice entry added?

This menu is for boards that need a built-in DTB, as MIPS currently
doesn't support appended DTBs it is the only way to load a DTB on
boards stuck with a broken boot loader. But as no board has been added
yet it only contain the entry for boards that don't need a built-in
DTB, which do nothing as you pointed out.

A board is then added in this menu in patch 14, for some reasons git
send-email didn't send the whole serie at once :(

Alban
