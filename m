Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Aug 2012 14:58:12 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:1430 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903524Ab2HVM6E (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 Aug 2012 14:58:04 +0200
Received: from [10.9.200.133] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 22 Aug 2012 05:56:54 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Wed, 22 Aug 2012 05:57:08 -0700
Received: from jayachandranc.netlogicmicro.com (unknown [10.7.0.77]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 4278F9F9F5; Wed, 22
 Aug 2012 05:57:44 -0700 (PDT)
Date:   Wed, 22 Aug 2012 18:27:46 +0530
From:   "Jayachandran C." <jchandra@broadcom.com>
To:     "Ralf Baechle" <ralf@linux-mips.org>
cc:     "Jayachandran C" <jayachandranc@netlogicmicro.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 12/12] MIPS: Netlogic: XLP defconfig update
Message-ID: <20120822125745.GA17819@jayachandranc.netlogicmicro.com>
References: <1342196605-4260-1-git-send-email-jayachandranc@netlogicmicro.com>
 <1342196605-4260-13-git-send-email-jayachandranc@netlogicmicro.com>
 <20120821125221.GC2550@linux-mips.org>
MIME-Version: 1.0
In-Reply-To: <20120821125221.GC2550@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-WSS-ID: 7C2A089C3MK23102546-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
X-archive-position: 34341
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Aug 21, 2012 at 02:52:21PM +0200, Ralf Baechle wrote:
> On Fri, Jul 13, 2012 at 09:53:25PM +0530, Jayachandran C wrote:
> 
> > +CONFIG_PARTITION_ADVANCED=y
> > +CONFIG_ACORN_PARTITION=y
> > +CONFIG_ACORN_PARTITION_ICS=y
> > +CONFIG_ACORN_PARTITION_RISCIX=y
> > +CONFIG_OSF_PARTITION=y
> > +CONFIG_AMIGA_PARTITION=y
> > +CONFIG_ATARI_PARTITION=y
> > +CONFIG_MAC_PARTITION=y
> > +CONFIG_BSD_DISKLABEL=y
> > +CONFIG_MINIX_SUBPARTITION=y
> > +CONFIG_SOLARIS_X86_PARTITION=y
> > +CONFIG_UNIXWARE_DISKLABEL=y
> > +CONFIG_LDM_PARTITION=y
> > +CONFIG_SGI_PARTITION=y
> > +CONFIG_ULTRIX_PARTITION=y
> > +CONFIG_SUN_PARTITION=y
> > +CONFIG_KARMA_PARTITION=y
> > +CONFIG_EFI_PARTITION=y
> > +CONFIG_SYSV68_PARTITION=y
> 
> Plenty of weird partition types enabled in this config update; you may
> want to review the config file for a future version.  Unless you really
> want to be able to deal with 1980's partitioning schemes, of course.

This seems to be present from the very first version, and got rearranged
when I regenerated this file. Will clean this up with the next update.

Thanks,
JC.
