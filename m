Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Feb 2013 22:00:54 +0100 (CET)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:36176 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827521Ab3BTVAws0cV1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Feb 2013 22:00:52 +0100
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id 0F87C5ED;
        Wed, 20 Feb 2013 22:00:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Qi8F2albXE4k; Wed, 20 Feb 2013 22:00:21 +0100 (CET)
Received: from [192.168.178.21] (ppp-188-174-115-35.dynamic.mnet-online.de [188.174.115.35])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id 444BB5EC;
        Wed, 20 Feb 2013 22:00:20 +0100 (CET)
Message-ID: <512539ED.8020308@metafoo.de>
Date:   Wed, 20 Feb 2013 22:02:37 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20121215 Icedove/3.0.11
MIME-Version: 1.0
To:     Steven Hill <Steven.Hill@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Kristian Kielhofner <kris@krisk.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: sead3_led: Use LED_CORE_SUSPENDRESUME
References: <1361104102-13294-1-git-send-email-lars@metafoo.de> <0573B2AE5BBFFC408CC8740092293B5ACB3CB7@bamail02.ba.imgtec.org>,<51253531.90001@metafoo.de> <0573B2AE5BBFFC408CC8740092293B5ACB40F9@bamail02.ba.imgtec.org>
In-Reply-To: <0573B2AE5BBFFC408CC8740092293B5ACB40F9@bamail02.ba.imgtec.org>
X-Enigmail-Version: 1.0.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 35797
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 02/20/2013 09:44 PM, Steven Hill wrote:
> Lars,
> 
> Please format patches for Malta and SEAD-3 to be against my 'linux-sjhill.git' repo and the 'mti-next' branch. Thanks.

Hi,

Can you fixup the patch manually in this case? It's probably faster for both of
us than having me re-send the patch.

Btw. I think it would be a good idea to add the information about your git repo
to MAINTAINERS.

- Lars
