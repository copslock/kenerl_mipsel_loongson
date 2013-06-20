Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jun 2013 09:22:54 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:3671 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817128Ab3FTHWwJ3M90 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Jun 2013 09:22:52 +0200
Received: from [10.9.208.57] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Thu, 20 Jun 2013 00:16:53 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Thu, 20 Jun 2013 00:22:10 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Thu, 20 Jun 2013 00:22:10 -0700
Received: from jayachandranc.netlogicmicro.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 55CB6F2D72; Thu, 20
 Jun 2013 00:22:09 -0700 (PDT)
Date:   Thu, 20 Jun 2013 12:52:11 +0530
From:   "Jayachandran C." <jchandra@broadcom.com>
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 0/2] Revert commits preventing platforms from
 booting.
Message-ID: <20130620072210.GB21634@jayachandranc.netlogicmicro.com>
References: <1371663632-30252-1-git-send-email-Steven.Hill@imgtec.com>
MIME-Version: 1.0
In-Reply-To: <1371663632-30252-1-git-send-email-Steven.Hill@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-WSS-ID: 7DDC73EE1R034228502-08-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37046
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

On Wed, Jun 19, 2013 at 12:40:30PM -0500, Steven J. Hill wrote:
> These revert two patches that prevent all MTI and bcm63xx platforms
> from booting. The kernel boot quietly hangs and gives not indication
> of what happened.

One issue which could cause this was fixed in the latest upstream-sfr.git,
but if this is happening again, can you please send me a .config which
shows the problem?

I have tested different malta configurations on qemu and none of them
show the issue.

Thanks,
JC.
