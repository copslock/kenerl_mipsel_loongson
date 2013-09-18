Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2013 13:29:25 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:48764 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824104Ab3IRL3VufV3Z (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Sep 2013 13:29:21 +0200
Message-ID: <52398E51.6050306@imgtec.com>
Date:   Wed, 18 Sep 2013 12:28:17 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Kconfig: CMP support needs to select SMP as well
References: <1378460846-961-1-git-send-email-markos.chandras@imgtec.com> <20130918111053.GK22468@linux-mips.org>
In-Reply-To: <20130918111053.GK22468@linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_09_18_12_29_16
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37843
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 09/18/13 12:10, Ralf Baechle wrote:
> On Fri, Sep 06, 2013 at 10:47:26AM +0100, Markos Chandras wrote:
>
>> The CMP code is only designed to work with SMP configurations.
>> Fixes multiple build problems on certain randconfigs:
>
> Applied - but I think the logic here may be backwards from a user's
> perspective.  Shouldn't a user be asked for SMP first, then for
> possible platform suboptions (CMP, VSMP, SMTC) of SMP?
>
>    Ralf
>
Hi Ralf,

Well, for example, you can have VSMP with or without CMP so CMP is not
another SMP option but rather an "add-on". However, it might be 
preferred to move the SMP option higher in the menu.
