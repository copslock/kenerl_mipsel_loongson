Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jul 2010 11:19:58 +0200 (CEST)
Received: from mga09.intel.com ([134.134.136.24]:65001 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491044Ab0GNJTs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Jul 2010 11:19:48 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP; 14 Jul 2010 02:18:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.55,201,1278313200"; 
   d="scan'208";a="535382465"
Received: from unknown (HELO sortiz-mobl) ([10.255.17.103])
  by orsmga002.jf.intel.com with ESMTP; 14 Jul 2010 02:20:10 -0700
Date:   Wed, 14 Jul 2010 11:19:35 +0200
From:   Samuel Ortiz <sameo@linux.intel.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] MFD: Add JZ4740 ADC driver
Message-ID: <20100714091934.GA2771@sortiz-mobl>
References: <1276924111-11158-23-git-send-email-lars@metafoo.de>
 <1278899288-14921-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1278899288-14921-1-git-send-email-lars@metafoo.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <sameo@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sameo@linux.intel.com
Precedence: bulk
X-list: linux-mips

Hi Lars,

On Mon, Jul 12, 2010 at 03:48:08AM +0200, Lars-Peter Clausen wrote:
> This patch adds a MFD driver for the JZ4740 ADC unit. The driver is used to
> demultiplex IRQs and synchronize access to shared registers between the battery,
> hwmon and (future) touchscreen driver.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
Patch applied, many thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
