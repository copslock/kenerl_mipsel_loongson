Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jun 2012 21:08:51 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:18254 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903720Ab2FETIr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jun 2012 21:08:47 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4fce59af0000>; Tue, 05 Jun 2012 12:10:39 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 5 Jun 2012 12:08:44 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 5 Jun 2012 12:08:43 -0700
Message-ID: <4FCE593B.10808@cavium.com>
Date:   Tue, 05 Jun 2012 12:08:43 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Jim Faulkner <jfaulkne@ccs.neu.edu>
CC:     linux-mips@linux-mips.org
Subject: Re: booting linux-3.3 or linux 3.4 on an SGI O2?
References: <20120605190047.GA6263@alumni-linux.ccs.neu.edu>
In-Reply-To: <20120605190047.GA6263@alumni-linux.ccs.neu.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Jun 2012 19:08:43.0931 (UTC) FILETIME=[A049BEB0:01CD434E]
X-archive-position: 33513
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
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

On 06/05/2012 12:00 PM, Jim Faulkner wrote:
> Hi all, I haven't been able to boot any kernels after linux 3.2 on my
> SGI O2.  I've tried linux-3.3.5 and linux-3.4.0, but neither would boot.
> Unfortunately I don't have further information such as a kernel panic,
> since I don't get any video output after the kernel is loaded.  I've
> attached my linux-3.4 .config.  Anybody know what patches I might need
> to get the latest kernels booting on this system?
>

I have had problems as well.

Someone should configure a serial console and early printk to see if 
they can see what is happening.

David Daney
