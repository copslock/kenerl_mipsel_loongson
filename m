Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2014 14:41:28 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:46469 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6871399AbaBTNl0vNX0d (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Feb 2014 14:41:26 +0100
Date:   Thu, 20 Feb 2014 13:41:20 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     <linux-mips@linux-mips.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 09/10] cpuidle: declare cpuidle_dev in cpuidle.h
Message-ID: <20140220134118.GT25765@pburton-linux.le.imgtec.org>
References: <1389794137-11361-1-git-send-email-paul.burton@imgtec.com>
 <1389794137-11361-10-git-send-email-paul.burton@imgtec.com>
 <53060496.6000303@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53060496.6000303@linaro.org>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Originating-IP: [192.168.154.79]
X-SEF-Processed: 7_3_0_01192__2014_02_20_13_41_21
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On Thu, Feb 20, 2014 at 02:35:18PM +0100, Daniel Lezcano wrote:
> On 01/15/2014 02:55 PM, Paul Burton wrote:
> >Declaring this allows drivers which need to initialise each struct
> >cpuidle_device at initialisation time to make use of the structures
> >already defined in cpuidle.c, rather than having to wastefully define
> >their own.
> >
> >Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> >Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> >Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> >Cc: linux-pm@vger.kernel.org
> >---
> >  include/linux/cpuidle.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> >diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> >index 50fcbb0..bab4f33 100644
> >--- a/include/linux/cpuidle.h
> >+++ b/include/linux/cpuidle.h
> >@@ -84,6 +84,7 @@ struct cpuidle_device {
> >  };
> >
> >  DECLARE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
> >+DECLARE_PER_CPU(struct cpuidle_device, cpuidle_dev);
> 
> 
> Nak. When a device is registered, it is assigned to the cpuidle_devices
> pointer and the backend driver should use it.
> 

Yes, but then if the driver needs to initialise the coupled_cpus mask
then it cannot do so until after the device has been registered. During
registration the cpuidle_coupled_register_device will then see the empty
coupled_cpus mask & do nothing. The only other ways around this would be
for the driver to define its own per-cpu struct cpuidle_device (which as
I state in the commit message seems wasteful when cpuidle already
defined them), or for cpuidle_coupled_register_device to be called later
after the driver had a chance to modify devices via the cpuidle_devices
pointers.

Paul

> 
> 
> -- 
>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 
