Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jul 2014 16:12:38 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44515 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6861343AbaGQOMdpRf5Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jul 2014 16:12:33 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 1AD015B57FC5F;
        Thu, 17 Jul 2014 15:12:24 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 17 Jul
 2014 15:12:26 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 17 Jul 2014 15:12:26 +0100
Received: from [192.168.154.67] (192.168.154.67) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 17 Jul
 2014 15:12:26 +0100
Message-ID: <53C7D9CA.20405@imgtec.com>
Date:   Thu, 17 Jul 2014 15:12:26 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Andrey Utkin <andrey.krieger.utkin@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <dborkman@redhat.com>, <ralf@linux-mips.org>
Subject: Re: [PATCH 2/3] arch/mips/net/bpf_jit.c: fix failure check
References: <1405603655-12571-1-git-send-email-andrey.krieger.utkin@gmail.com>  <53C7D52E.5020205@imgtec.com> <CANZNk81DOOxYYFSKZMCh=uABd3ONB8wToTFc3_L_9TfyQDS1yQ@mail.gmail.com>
In-Reply-To: <CANZNk81DOOxYYFSKZMCh=uABd3ONB8wToTFc3_L_9TfyQDS1yQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.67]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41276
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

On 07/17/2014 02:58 PM, Andrey Utkin wrote:
> 2014-07-17 16:52 GMT+03:00 Markos Chandras <Markos.Chandras@imgtec.com>:
>> Thanks for the patch. I would personally prefer to use a new signed int
>> variable, but I am fine either way.
> 
> If that's not a problem for performance etc., then i'll resubmit with
> new temporary signed variable, because i believe it would be simpler
> to comprehend.
> 
Hi Andrey,

Well, this function is executed during the filter compilation so it's
only executed once (or maybe a few times) per filter (assuming the
filter uses the SKF_AD_PKTTYPE opcode at all) so performance is not
really critical at this point. The performance become a critical factor
for the execution of the jitted filter. But yes, avoiding passing the
argument and doing the pointer operation later on could save some
instructions which is both good for compilation performance and also
makes the function simpler as you said.

-- 
markos
