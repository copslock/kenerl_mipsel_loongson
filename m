Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Sep 2013 09:27:20 +0200 (CEST)
Received: from smtp-out-193.synserver.de ([212.40.185.193]:1076 "EHLO
        smtp-out-191.synserver.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6867544Ab3ILH1RtLryG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Sep 2013 09:27:17 +0200
Received: (qmail 27149 invoked by uid 0); 12 Sep 2013 07:27:09 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 27095
Received: from p549ce228.dip0.t-ipconnect.de (HELO ?192.168.0.176?) [84.156.226.40]
  by 217.119.54.77 with AES256-SHA encrypted SMTP; 12 Sep 2013 07:27:08 -0000
Message-ID: <52316D28.5000100@metafoo.de>
Date:   Thu, 12 Sep 2013 09:28:40 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130827 Icedove/17.0.8
MIME-Version: 1.0
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
CC:     linux-mips@linux-mips.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        ralf@linux-mips.org
Subject: Re: [PATCH v2] MIPS: GIC: Select R4K counter as fallback.
References: <1378929101-7021-1-git-send-email-Steven.Hill@imgtec.com>
In-Reply-To: <1378929101-7021-1-git-send-email-Steven.Hill@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37795
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

On 09/11/2013 09:51 PM, Steven J. Hill wrote:
> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> 
> If CONFIG_CSRC_GIC is selected and the GIC is not found during
> boot, then fallback to the R4K counter gracefully.

Is there any reason not to always register the r4k clocksource, no matter
whether the gic clocksource is present or not? The timekeeping core of the
kernel will make sure to use the best available clocksource based on the
clocksource's rating.

- Lars
