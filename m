Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Feb 2015 18:56:55 +0100 (CET)
Received: from unicorn.mansr.com ([81.2.72.234]:45527 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012426AbbBBR4xcfVED convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Feb 2015 18:56:53 +0100
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 67B8E1538A; Mon,  2 Feb 2015 17:56:47 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc:     Oleg Kolosov <bazurbat@gmail.com>, <linux-mips@linux-mips.org>
Subject: Re: Few questions about porting Linux to SMP86xx boards
References: <54CEACC1.1040701@gmail.com> <54CF9577.6040004@imgtec.com>
Date:   Mon, 02 Feb 2015 17:56:47 +0000
In-Reply-To: <54CF9577.6040004@imgtec.com> (Steven J. Hill's message of "Mon,
        2 Feb 2015 09:19:19 -0600")
Message-ID: <yw1x1tm8b3j4.fsf@unicorn.mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mru@mansr.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45616
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mans@mansr.com
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

"Steven J. Hill" <Steven.Hill@imgtec.com> writes:

> On 02/01/2015 04:46 PM, Oleg Kolosov wrote:
>> Hello MIPS gurus!
>> 
> Hello.
>
>> I'm adding support for Sigma Designs SMP8652/SMP8654 (Tango3 family,
>> MIPS 24kf CPU) to newer kernel. I've selectively adapted patches from
>> 2.6.32.15 (the latest officially available for us) to the latest mips
>> 3.18 stable branch and things seem to work (it boots, runs simple test
>> programs), but there are few questions which I was not able to resolve
>> yet with my limited experience:
>> 
> It is good to hear somebody is working with that hardware. I have
> uploaded all the Sigma source that we were given along with their root
> file system images. A lot is for the 8910, but there is stuff in there
> for the 86xx family as well.
>
> Steve
>
> http://www.linux-mips.org/pub/linux/mips/people/sjhill/Sigma/

I have a bunch of cleaned/rewritten 86xx drivers for 3.19 here:
https://github.com/mansr/linux-tangox

-- 
Måns Rullgård
mans@mansr.com
