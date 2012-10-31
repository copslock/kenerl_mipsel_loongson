Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2012 15:34:24 +0100 (CET)
Received: from mms2.broadcom.com ([216.31.210.18]:2741 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824847Ab2JaOeWnkRLk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 31 Oct 2012 15:34:22 +0100
Received: from [10.9.200.133] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 31 Oct 2012 07:32:18 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Wed, 31 Oct 2012 07:33:35 -0700
Received: from jayachandranc.netlogicmicro.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 0E0C840FEC; Wed, 31
 Oct 2012 07:34:03 -0700 (PDT)
Date:   Wed, 31 Oct 2012 20:07:35 +0530
From:   "Jayachandran C." <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 12/15] MIPS: Netlogic: Introduce support for
 multi-node
Message-ID: <20121031143734.GA18568@jayachandranc.netlogicmicro.com>
References: <cover.1351687453.git.jchandra@broadcom.com>
 <995719ada6db71c86b332df4698c1dbf748686c0.1351687453.git.jchandra@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <995719ada6db71c86b332df4698c1dbf748686c0.1351687453.git.jchandra@broadcom.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-WSS-ID: 7C8FE9F83QC1997164-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
X-archive-position: 34813
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

On Wed, Oct 31, 2012 at 06:31:38PM +0530, Jayachandran C wrote:
> Upto 4 Netlogic XLP SoCs can be connected over ICI links to form a
> coherent multi-node system.  Each SoC has its own set of on-chip
> devices including PIC.  To support this, add a per SoC stucture and
> use it for the PIC and SYS block addresses instead of using global
> variables.
> 
> Signed-off-by: Jayachandran C <jchandra@broadcom.com>

This is an older version of the patch, please ignore.  I have marked
it superceded in patchwork as well.

JC.
