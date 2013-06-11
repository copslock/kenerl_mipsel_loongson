Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jun 2013 13:43:25 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:1303 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835108Ab3FKLnQm5VRM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Jun 2013 13:43:16 +0200
Received: from [10.9.208.57] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Tue, 11 Jun 2013 04:39:21 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Tue, 11 Jun 2013 04:43:01 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP
 Server id 14.1.438.0; Tue, 11 Jun 2013 04:43:01 -0700
Received: from jayachandranc.netlogicmicro.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id DA951F2D73; Tue, 11
 Jun 2013 04:42:59 -0700 (PDT)
Date:   Tue, 11 Jun 2013 17:14:31 +0530
From:   "Jayachandran C." <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH v3 0/4]Use scratch registers on XLR/XLS/XLP
Message-ID: <20130611114430.GA9517@jayachandranc.netlogicmicro.com>
References: <1370849733-5074-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <1370849733-5074-1-git-send-email-jchandra@broadcom.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-WSS-ID: 7DA9D3E331W34630869-02-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36827
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

On Mon, Jun 10, 2013 at 01:05:29PM +0530, Jayachandran C wrote:
> This set of patches enable the use of scratch registers on XLR/XLS and XLP
> (cop0 reg 22, sel 0-7) to optimize the generated TLB handlers.

Looks like I submitted an older version of this patchset - I will post the
updated version.

I have marked the patches as superseded in patchwork.

JC.
