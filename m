Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Oct 2015 17:33:52 +0200 (CEST)
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:46365 "EHLO
        pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007186AbbJJPduoKlCw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Oct 2015 17:33:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=pandora-2014;
        h=Sender:In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=XWF2+F8ckbDoz/1kv0qxP+J6AMgK9h6MV9EbFnYkXso=;
        b=qjqCkW2QwfMIgOnk8Hv4PtcOXU0/EKU8v9w/bPHmMDNguj9Y6Oy9xsdHfGIJ4s5UEsbX+1HHy6KgI6beQ46ox4r/wiuTAEMBLl60KvvcYkfib+uHg5ClPVV1dTkHboU7oDI53kmg+hgQnn4sLU0fMcVgPDd0i3++Hg8gopiy8Xs=;
Received: from n2100.arm.linux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:53294)
        by pandora.arm.linux.org.uk with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1Zkw9T-0007MW-Va; Sat, 10 Oct 2015 16:33:40 +0100
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1Zkw9R-0003cH-0m; Sat, 10 Oct 2015 16:33:37 +0100
Date:   Sat, 10 Oct 2015 16:33:36 +0100
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-cris-kernel@axis.com,
        linux-mips@linux-mips.org, linux-xtensa@linux-xtensa.org,
        kernel@stlinux.com, linux-rpi-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] sched_clock: add data pointer argument to read callback
Message-ID: <20151010153336.GE32536@n2100.arm.linux.org.uk>
References: <1444427858-576-1-git-send-email-mans@mansr.com>
 <20151009232015.GC32536@n2100.arm.linux.org.uk>
 <yw1x4mhzioxl.fsf@unicorn.mansr.com>
 <20151009235441.GD32536@n2100.arm.linux.org.uk>
 <yw1xzizrh7ug.fsf@unicorn.mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xzizrh7ug.fsf@unicorn.mansr.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@arm.linux.org.uk
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

On Sat, Oct 10, 2015 at 01:42:47AM +0100, Måns Rullgård wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> > On Sat, Oct 10, 2015 at 12:48:22AM +0100, Måns Rullgård wrote:
> >> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> >> 
> >> > On Fri, Oct 09, 2015 at 10:57:35PM +0100, Mans Rullgard wrote:
> >> >> This passes a data pointer specified in the sched_clock_register()
> >> >> call to the read callback allowing simpler implementations thereof.
> >> >> 
> >> >> In this patch, existing uses of this interface are simply updated
> >> >> with a null pointer.
> >> >
> >> > This is a bad description.  It tells us what the patch is doing,
> >> > (which we can see by reading the patch) but not _why_.  Please include
> >> > information on why the change is necessary - describe what you are
> >> > trying to achieve.
> >> 
> >> Currently most of the callbacks use a global variable to store the
> >> address of a counter register.  This has several downsides:
> >> 
> >> - Loading the address of a global variable can be more expensive than
> >>   keeping a pointer next to the function pointer.
> >> 
> >> - It makes it impossible to have multiple instances of a driver call
> >>   sched_clock_register() since the caller can't know which clock will
> >>   win in the end.
> >> 
> >> - Many of the existing callbacks are practically identical and could be
> >>   replaced with a common generic function if it had a pointer argument.
> >> 
> >> If I've missed something that makes this a stupid idea, please tell.
> >
> > So my next question is whether you intend to pass an iomem pointer
> > through this, or a some kind of structure, or both.  It matters,
> > because iomem pointers have a __iomem attribute to keep sparse
> > happy.  Having to force that attribute on and off pointers is frowned
> > upon, as it defeats the purpose of the sparse static checker.
> 
> So this is an instance where tools like sparse get in the way of doing
> the simplest, most efficient, and obviously correct thing.  Who wins in
> such cases?

In that case, NAK on the patch.  I don't have time for your stupid games.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
