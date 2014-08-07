Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Aug 2014 13:39:58 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25069 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6862687AbaHGLjgWPSEv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Aug 2014 13:39:36 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C115D2C8A4095;
        Thu,  7 Aug 2014 12:39:26 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 7 Aug
 2014 12:39:28 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 7 Aug 2014 12:39:28 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 7 Aug
 2014 12:39:27 +0100
Message-ID: <53E3656F.7000106@imgtec.com>
Date:   Thu, 7 Aug 2014 12:39:27 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>,
        Apelete Seketeli <apelete@seketeli.net>
CC:     linux-mips <linux-mips@linux-mips.org>
Subject: Re: Please update two patches
References: <CAAhV-H5o_vDqCmRJ8qne7-dOzg3Ai6bnSkqZ6dLc=hN1fjr7XQ@mail.gmail.com> <20140805173540.GA20250@linux-mips.org> <20140806192627.GA26040@amegan> <20140807063406.GB5855@linux-mips.org>
In-Reply-To: <20140807063406.GB5855@linux-mips.org>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41895
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

Hi Ralf,

On 07/08/14 07:34, Ralf Baechle wrote:
> On Wed, Aug 06, 2014 at 09:26:27PM +0200, Apelete Seketeli wrote:
>> I've been wondering how can one knows when pull requests from
>> linux-mips are sent out to Linus.
>> Is there a separate mailing list where those pull requests are
>> published (I couldn't find anything by searching LKML) ?
> 
> I've never copied them to mailing lists.

Would you be willing to start Cc'ing the list on pull request emails?

I too would find that timing information of value, and it would also
help disseminate the information about what changes are reaching
mainline, particularly fixes and larger features, without having to
explicitly look for the merge commit which contains that summary every
so often:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=c9a606660e7bb5ba9169d279346417dab72b157d

Cheers
James
