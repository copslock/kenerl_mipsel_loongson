Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2005 21:44:26 +0100 (BST)
Received: from localhost.localdomain ([IPv6:::ffff:127.0.0.1]:57268 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225364AbVGVUoJ>; Fri, 22 Jul 2005 21:44:09 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j6MJHc7I005215;
	Fri, 22 Jul 2005 15:17:38 -0400
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j6MJHWjs005204;
	Fri, 22 Jul 2005 15:17:32 -0400
Date:	Fri, 22 Jul 2005 15:17:32 -0400
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Clark Williams <williams@redhat.com>
Cc:	Rodolfo Giometti <giometti@linux.it>, linux-mips@linux-mips.org
Subject: Re: Battery status
Message-ID: <20050722191732.GB3770@linux-mips.org>
References: <20050722142205.GE21044@enneenne.com> <1122044036.10743.5.camel@riff>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1122044036.10743.5.camel@riff>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8616
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 22, 2005 at 09:53:56AM -0500, Clark Williams wrote:

> > I'd like to implement a way to allow userspace to read battery status
> > (or percentage).  I notice this port of APM interface for ARM
> > architecture «arch/arm/kernel/apm.c» and I think I can use comething
> > similar... what do you think about that?
> 
> You might want to look at how acpi is presented in the /proc interface.
> You could hook your battery status routines into the acpi entries:
> 
> 	/proc/acpi/battery/BAT0/{alarm,info,status} 
> 
> Just a thought.

Forget it.  One of the great advantages of MIPS is that Intel has ACPI.
On the open Richter scale for stupidity ACPI in computing is a 9.8.

  Ralf
