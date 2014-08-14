Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Aug 2014 17:09:42 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30427 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6901545AbaHNPJey8VJr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Aug 2014 17:09:34 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 84C4C943AA80;
        Thu, 14 Aug 2014 16:09:24 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 14 Aug
 2014 16:09:27 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 14 Aug 2014 16:09:27 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 14 Aug
 2014 16:09:27 +0100
Message-ID: <53ECD126.7090103@imgtec.com>
Date:   Thu, 14 Aug 2014 16:09:26 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: Bug tracking system
References: <20140814145558.GA17477@linux-mips.org>
In-Reply-To: <20140814145558.GA17477@linux-mips.org>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42101
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

On 14/08/14 15:55, Ralf Baechle wrote:
> While I'm tinkering with the system - linux-mips.org still has no
> bug tracking system to track bugs and so issues get forgotten also the
> only system we have to track feature requests and other to-do items
> currently is the to do page in the wiki.  But the wiki isn't the best
> medium for this purpose.  So should we install something like bugzilla -
> which I personally never liked - or other tracking system?  Suggestions?

If bugzilla is to be used, would it make sense to use the kernel.org
bugzilla which already has a MIPS category, rather than setting up a new
one?

https://bugzilla.kernel.org/buglist.cgi?product=Platform%20Specific%2FHardware&component=MIPS&resolution=---

Cheers
James
