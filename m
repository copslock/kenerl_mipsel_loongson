Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2012 11:04:04 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:41023 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903438Ab2HPJEB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Aug 2012 11:04:01 +0200
Message-ID: <502CB736.6010107@openwrt.org>
Date:   Thu, 16 Aug 2012 11:02:46 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
CC:     Wolfram Sang <w.sang@pengutronix.de>, linux-i2c@vger.kernel.org,
        linux-mips@linux-mips.org, Thomas Langer <thomas.langer@lantiq.com>
Subject: Re: [PATCH] I2C: MIPS: lantiq: add FALC-ON i2c bus master
References: <1345102448-4612-1-git-send-email-blogic@openwrt.org> <CAM=Q2cvCmKMkQjWd0nvuvMMkNt3sH-AcupCq_KzM7EXDuD_-wQ@mail.gmail.com>
In-Reply-To: <CAM=Q2cvCmKMkQjWd0nvuvMMkNt3sH-AcupCq_KzM7EXDuD_-wQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 34194
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Hi Shubhrajyoti,

Thanks for the comments, I just noticed that clk_put() is also missing
and that the clock gate should be deactivated upon a rmmod ... i will
fix all of these and resend the patch.

John
