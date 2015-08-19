Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Aug 2015 21:40:08 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:35749 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012900AbbHSTkGZWbpT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Aug 2015 21:40:06 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id t7JJe4v9021915;
        Wed, 19 Aug 2015 21:40:04 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id t7JJe3DI021913;
        Wed, 19 Aug 2015 21:40:03 +0200
Date:   Wed, 19 Aug 2015 21:40:03 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Aaro Koskinen <aaro.koskinen@nokia.com>, linux-mips@linux-mips.org,
        Janne Huttunen <janne.huttunen@nokia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH 00/14] MIPS/staging: OCTEON: enable ethernet/xaui on
 CN68XX
Message-ID: <20150819194003.GL3612@linux-mips.org>
References: <1439472106-7750-1-git-send-email-aaro.koskinen@nokia.com>
 <55CCED1B.6030701@caviumnetworks.com>
 <20150814130912.GR1199@ak-desktop.emea.nsn-net.net>
 <55CE4666.4050307@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55CE4666.4050307@caviumnetworks.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48945
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Fri, Aug 14, 2015 at 12:49:58PM -0700, David Daney wrote:

> If what you have now works, I would merge this patch set, so:
> 
> Acked-by: David Daney <david.daney@cavium.com>
> 
> 
> Follow-on improvements can be made with additional patches.

Cool, thanks.  Queued for kernel $n + 1.

  Ralf
