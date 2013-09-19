Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Sep 2013 22:37:01 +0200 (CEST)
Received: from avon.wwwdotorg.org ([70.85.31.133]:35734 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6832656Ab3ISUgz53rHb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Sep 2013 22:36:55 +0200
Received: from severn.wwwdotorg.org (unknown [192.168.65.5])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPS id 25BE52200C;
        Thu, 19 Sep 2013 14:36:52 -0600 (MDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by severn.wwwdotorg.org (Postfix) with ESMTPSA id 3BDEEE461B;
        Thu, 19 Sep 2013 14:36:49 -0600 (MDT)
Message-ID: <523B605F.8090402@wwwdotorg.org>
Date:   Thu, 19 Sep 2013 14:36:47 -0600
From:   Stephen Warren <swarren@wwwdotorg.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
MIME-Version: 1.0
To:     Johannes Sixt <j6t@kdbg.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Grant Likely <grant.likely@linaro.org>,
        Rob Herring <rob.herring@calxeda.com>,
        devicetree@vger.kernel.org, git@vger.kernel.org,
        steven.hill@imgtec.com, mmarek@suse.cz, swarren@nvidia.com,
        linux-mips@linux-mips.org, linux-kbuild@vger.kernel.org,
        james.hogan@imgtec.com
Subject: Re: git issue / [PATCH] MIPS: fix invalid symbolic link file
References: <1379596148-32520-1-git-send-email-maddy@linux.vnet.ibm.com> <20130919133920.GA22468@linux-mips.org> <523B555E.2070508@kdbg.org>
In-Reply-To: <523B555E.2070508@kdbg.org>
X-Enigmail-Version: 1.4.6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.97.8 at avon.wwwdotorg.org
X-Virus-Status: Clean
Return-Path: <swarren@wwwdotorg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37893
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: swarren@wwwdotorg.org
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

On 09/19/2013 01:49 PM, Johannes Sixt wrote:
> Am 19.09.2013 15:39, schrieb Ralf Baechle:
>> The original patch that introduced the symlink with the \n is kernel
>> commit 3b29aa5ba204c62b3ec8f9f5b1ebd6e5d74f75d3 and is archived in
>> patchwork at http://patchwork.linux-mips.org/patch/5745/  The patch
>> file contains a \n at the end - but one would expect that from a
>> patch file that has been transfered via email, so I'm not sure how this
>> is supposed to work with emailed patches?!?
> 
> The mbox file I downloaded from this link looks like this:
...
> but it should look like this:
...
> Whoever or whatever moved the '\ No newline at end of file' line above
> the patch text is to blame.

That sounds like a patchwork problem; the original copy of the message I
received looks correct.
