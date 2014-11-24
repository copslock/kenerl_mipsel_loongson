Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 20:53:59 +0100 (CET)
Received: from mail-ig0-f171.google.com ([209.85.213.171]:35482 "EHLO
        mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006914AbaKXTxyTeyEj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 20:53:54 +0100
Received: by mail-ig0-f171.google.com with SMTP id uq10so3756140igb.4
        for <multiple recipients>; Mon, 24 Nov 2014 11:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=k4iSY5IyUpV8UE5CGHbExs0JmIzttiyADQ7pQnwASHo=;
        b=QWeRexq9oK/4XblYOSXLWqQq/BNS4ZxcVSF2z6mqyc6RqCPlzZTkcjE+y+SirOrffk
         X0AGCD/9CdFJRDsFdEjfC4JW8Lvb6O7OkvlWUEPhzy7LKsmNbit2atz0jNg3zdFpt3XS
         mgpg0MZf6XnEVefD/fGf1yB9TjtfVPbXE+W7lyijRIJiKunoa5FUy65C8ao9tNd7AmXb
         7+/mS/sVCmwDmJ2cxaO8LYZlr+pfbhMI9GfuOhoHzgDbDxTXR7f2tLwE+UqctgOGEagF
         MZiPCMA8whVVwUTrrumZDC07zpt9f2BDEXKroUVjxIlyoDlk7QApkq0CTEoDVYQJl90M
         jW+g==
X-Received: by 10.50.66.227 with SMTP id i3mr13638515igt.25.1416858828399;
        Mon, 24 Nov 2014 11:53:48 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id kv4sm4944249igb.13.2014.11.24.11.53.47
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 24 Nov 2014 11:53:47 -0800 (PST)
Message-ID: <54738CCA.4090302@gmail.com>
Date:   Mon, 24 Nov 2014 11:53:46 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     James Cowgill <James.Cowgill@imgtec.com>,
        "Herrmann, Andreas" <Andreas.Herrmann@caviumnetworks.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: Re: [PATCH] MIPS: octeon: Add support for the UBNT E200 board
References: <1416837096-52243-1-git-send-email-James.Cowgill@imgtec.com> <54736A06.9070206@gmail.com> <20141124191301.GC6796@fuloong-minipc.musicnaut.iki.fi> <20141124194611.GD6796@fuloong-minipc.musicnaut.iki.fi>
In-Reply-To: <20141124194611.GD6796@fuloong-minipc.musicnaut.iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44397
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 11/24/2014 11:46 AM, Aaro Koskinen wrote:
> Hi,
>
> On Mon, Nov 24, 2014 at 09:13:01PM +0200, Aaro Koskinen wrote:
>> On Mon, Nov 24, 2014 at 09:25:26AM -0800, David Daney wrote:
>>> On 11/24/2014 05:51 AM, James Cowgill wrote:
>>>> From: Markos Chandras <markos.chandras@imgtec.com>
>>>>
>>>> Add support for the UBNT E200 board (EdgeRouter/EdgeRouter Pro 8 port).
>>>>
>>>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>>>> Signed-off-by: James Cowgill <James.Cowgill@imgtec.com>
>>>
>>> NACK.
>>>
>>> As far as I know, these boards have a boot loader that supplies a correct
>>> device tree, there should be no need to hack up the kernel like this.
>>>
>>> As far as I know, Andreas is running a kernel.org kernel on these boards
>>> without anything like this.
>>
>> It gets called from Octeon Ethernet driver through cvmx_helper_link_get()
>> frequently so the console gets spammed about unknown board, and probably
>> also the link status is bogus as a result.
>
> Just tested with 3.18-rc6 and this behaviour has been apparently
> fixed somehow. Cool.
>

It is magic!

If the kernel is built with the proper ethernet phy drivers *and* the 
device tree contains proper phy topology information, then the phy 
drivers handle link monitoring and none of the cvmx-* crap is used.

So for all boards with bootloaders that supply a device tree, there 
should never be any reason to patch in the hacky board identifiers to 
the kernel sources.

David.


> A.
>
>
