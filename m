Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jun 2013 23:16:10 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:34960 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6829860Ab3FEVQGJhnXF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 5 Jun 2013 23:16:06 +0200
Message-ID: <51AFAA8C.6080002@imgtec.com>
Date:   Wed, 5 Jun 2013 16:15:56 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH v6] MIPS: micromips: Fix improper definition of ISA exception
 bit.
References: <1370461798-20296-1-git-send-email-Steven.Hill@imgtec.com> <51AFA540.5010207@gmail.com>
In-Reply-To: <51AFA540.5010207@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.150.82]
X-SEF-Processed: 7_3_0_01192__2013_06_05_22_16_00
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36709
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

On 06/05/2013 03:53 PM, David Daney wrote:
>
> You can only manipulate this bit if you know microMIPS is supported.  So
> I think you should either not touch it for the non-microMIPS case, or
> make the write conditional on the presence of microMIPS support in the CPU.
>
I decided to surround with SYS_SUPPORTS_MICROMIPS so the function could 
be optimized out in v7 of the patch.
