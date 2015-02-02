Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Feb 2015 16:19:35 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52525 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012150AbbBBPTeExwbO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Feb 2015 16:19:34 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 57516A2F3E319;
        Mon,  2 Feb 2015 15:19:25 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 2 Feb
 2015 15:19:27 +0000
Received: from [192.168.159.174] (192.168.159.174) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Mon, 2 Feb 2015
 07:19:20 -0800
Message-ID: <54CF9577.6040004@imgtec.com>
Date:   Mon, 2 Feb 2015 09:19:19 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     Oleg Kolosov <bazurbat@gmail.com>, <linux-mips@linux-mips.org>
Subject: Re: Few questions about porting Linux to SMP86xx boards
References: <54CEACC1.1040701@gmail.com>
In-Reply-To: <54CEACC1.1040701@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.159.174]
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45607
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

On 02/01/2015 04:46 PM, Oleg Kolosov wrote:
> Hello MIPS gurus!
> 
Hello.

> I'm adding support for Sigma Designs SMP8652/SMP8654 (Tango3 family,
> MIPS 24kf CPU) to newer kernel. I've selectively adapted patches from
> 2.6.32.15 (the latest officially available for us) to the latest mips
> 3.18 stable branch and things seem to work (it boots, runs simple test
> programs), but there are few questions which I was not able to resolve
> yet with my limited experience:
> 
It is good to hear somebody is working with that hardware. I have
uploaded all the Sigma source that we were given along with their root
file system images. A lot is for the 8910, but there is stuff in there
for the 86xx family as well.

Steve


http://www.linux-mips.org/pub/linux/mips/people/sjhill/Sigma/
