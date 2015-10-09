Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Oct 2015 01:20:33 +0200 (CEST)
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:44965 "EHLO
        pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010051AbbJIXU30t15P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Oct 2015 01:20:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=pandora-2014;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=dYqeZrkLd+uUzoYryr+mKpSBqji93NWDD5lQSe1I/K4=;
        b=NTGak3Fp8wsoiRteoPfr0kmmKJfSoWcL/FEQuqSCsIF7sjqnz8lQwSIPfh8mhgAK1aJG+cpXMUE58IfN1tyys5tehJ6t63LEMZ5gcPkPfDJgiqE60X7jbiN3igwn9AcisqhaPEEsclM5hecy5w5BeZyyypSd9Tlvr98T2VrYlKE=;
Received: from n2100.arm.linux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:41715)
        by pandora.arm.linux.org.uk with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1ZkgxX-0001hi-J0; Sat, 10 Oct 2015 00:20:19 +0100
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1ZkgxU-00049N-Bi; Sat, 10 Oct 2015 00:20:16 +0100
Date:   Sat, 10 Oct 2015 00:20:15 +0100
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     Mans Rullgard <mans@mansr.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-cris-kernel@axis.com,
        linux-mips@linux-mips.org, linux-xtensa@linux-xtensa.org,
        kernel@stlinux.com, linux-rpi-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] sched_clock: add data pointer argument to read callback
Message-ID: <20151009232015.GC32536@n2100.arm.linux.org.uk>
References: <1444427858-576-1-git-send-email-mans@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1444427858-576-1-git-send-email-mans@mansr.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49477
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

On Fri, Oct 09, 2015 at 10:57:35PM +0100, Mans Rullgard wrote:
> This passes a data pointer specified in the sched_clock_register()
> call to the read callback allowing simpler implementations thereof.
> 
> In this patch, existing uses of this interface are simply updated
> with a null pointer.

This is a bad description.  It tells us what the patch is doing,
(which we can see by reading the patch) but not _why_.  Please include
information on why the change is necessary - describe what you are
trying to achieve.

I generally don't accept patches what add new stuff to the kernel with
no users of that new stuff - that's called experience, experience of
people who submit stuff like that, and then vanish leaving their junk
in the kernel without any users.  Please ensure that this gets a user
very quickly, or better still, submit this patch as part of a series
which makes use of it.

Also, copying soo many people is guaranteed to be silently dropped by
mailing lists.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
