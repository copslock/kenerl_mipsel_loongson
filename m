Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jun 2013 23:00:31 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:60254 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835275Ab3FMVA3kYc0S (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Jun 2013 23:00:29 +0200
Message-ID: <51BA32E3.7090006@imgtec.com>
Date:   Thu, 13 Jun 2013 16:00:19 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: sead3: Fix incorrect values for soft reset.
References: <1371075656-21374-1-git-send-email-Steven.Hill@imgtec.com> <20130613141820.GB22906@linux-mips.org>
In-Reply-To: <20130613141820.GB22906@linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.150.87]
X-SEF-Processed: 7_3_0_01192__2013_06_13_22_00_23
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36863
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

On 06/13/2013 09:18 AM, Ralf Baechle wrote:
> On Wed, Jun 12, 2013 at 05:20:56PM -0500, Steven J. Hill wrote:
>
> I think this is going to break Malta.  We used to have:
>
>      #define SOFTRES_REG       0x1e800050
>      #define GORESET           0x4d
>
> for SEAD
>
Yes, it does break Malta. The #define values are defined in two places 
and I missed one of them. I have submitted a patchset to these cleaned 
up. Both platforms can now perform soft resets. Also, the 0x1e800050 is 
not correct. I check all the way back in our 2.6.32.15 tree and that 
value does not show up anywhere. The value in the patchset for SEAD-3 is 
the correct one.

-Steve
