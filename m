Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jul 2011 13:09:34 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:1855 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491083Ab1GNLJa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Jul 2011 13:09:30 +0200
Received: from [10.9.200.131] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Thu, 14 Jul 2011 04:13:38 -0700
X-Server-Uuid: D3C04415-6FA8-4F2C-93C1-920E106A2031
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Thu, 14 Jul 2011 04:08:46 -0700
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.17.16.106]) by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 2CA1574D04; Thu, 14 Jul 2011 04:08:46 -0700 (PDT)
Received: from [10.176.68.26] (unknown [10.176.68.26]) by
 mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id EAFCC20501; Thu, 14
 Jul 2011 04:08:44 -0700 (PDT)
Message-ID: <4E1ECE3B.10308@broadcom.com>
Date:   Thu, 14 Jul 2011 13:08:43 +0200
From:   "Roland Vossen" <rvossen@broadcom.com>
Organization: Broadcom
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17)
 Gecko/20110424 Thunderbird/3.1.10
MIME-Version: 1.0
To:     "Jonas Gorski" <jonas.gorski@gmail.com>
cc:     "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org
Subject: Status of MIPS on 3.0.0-rc6 kernel
X-WSS-ID: 620010E85ZC697404-01-01
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 30620
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rvossen@broadcom.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10110

Hi Jonas,

The (defconfig) mips kernel fails to build, with the error message:

arch/mips/kernel/i8259.c:240: error: unknown field 'resume' specified in 
initializer

I read on https://lkml.org/lkml/2011/6/1/37 that Geert Uytterhoeven 
encountered the same issue on June 1st.

Do you know if there are still known problems building a 3.0.0-rc6 MIPS 
kernel ?

Thanks,

Roland.
