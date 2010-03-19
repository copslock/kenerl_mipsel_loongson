Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Mar 2010 23:38:30 +0100 (CET)
Received: from mail1.adax.com ([208.201.231.104]:22426 "EHLO mail1.adax.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492508Ab0CSWi1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Mar 2010 23:38:27 +0100
Received: from static-151-204-189-187.pskn.east.verizon.net (static-151-204-189-187.pskn.east.verizon.net [151.204.189.187])
        by mail1.adax.com (Postfix) with ESMTP id 260EB120A4C;
        Fri, 19 Mar 2010 15:38:24 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by static-151-204-189-187.pskn.east.verizon.net (Postfix) with ESMTP id 0580F400589;
        Fri, 19 Mar 2010 18:38:23 -0400 (EDT)
X-Virus-Scanned: amavisd-new at pskn.east.verizon.net
Received: from static-151-204-189-187.pskn.east.verizon.net ([127.0.0.1])
        by localhost (static-151-204-189-187.pskn.east.verizon.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id o+aA-rMOoT3d; Fri, 19 Mar 2010 18:38:02 -0400 (EDT)
Received: from [192.168.1.76] (jr001327.mtl-nj.adax [192.168.1.76])
        by static-151-204-189-187.pskn.east.verizon.net (Postfix) with ESMTP id EBF29400571;
        Fri, 19 Mar 2010 18:38:01 -0400 (EDT)
Message-ID: <4BA3FCD9.2020205@adax.com>
Date:   Fri, 19 Mar 2010 18:38:17 -0400
From:   Jan Rovins <janr@adax.com>
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>
CC:     Peter 'p2' De Schrijver <p2@debian.org>, linux-mips@linux-mips.org
Subject: Re: linux 2.6.33 on movidis x16
References: <20100305141113.GD2437@apfelkorn> <4B9EB45D.8050106@adax.com> <20100318181734.GG2437@apfelkorn> <4BA27048.2010707@caviumnetworks.com> <4BA277FB.6080808@adax.com> <20100319175244.GH2437@apfelkorn> <4BA3DE2D.1070801@adax.com> <4BA3F4AC.5000307@caviumnetworks.com>
In-Reply-To: <4BA3F4AC.5000307@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <janr@adax.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: janr@adax.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> On 03/19/2010 01:27 PM, Jan Rovins wrote:
>
>
>>       case CVMX_BOARD_TYPE_KBP: /* JLR first Movidis X16 */
>>     case CVMX_BOARD_TYPE_CUST_WSX16: /* JLR second Movidis X16 */
>>            /* Board has 8 SGMII ports. 4 connect out, two connect to 
>> a switch,
>>                and 2 loop to each other */
>>            if ((ipd_port >= 0) && (ipd_port < 4))
>>                return ipd_port+1;
>>            else
>>                return -1;
>
> I don't think that is correct.  I just verified that that PHYs are on
> addresses 0-7.  That code makes them start at 1.
>
> The Octeon mdio bus driver also needs a small change.
>
> I am working on a patch.
You are most likely right.
using  ipd_port+1 is probably what made my eth0 show up on the 2nd RJ45 
port.
We were just using those boxes for early development, to verify basic 
Octeon functionality of some of our hardware drivers, so once an 
Ethernet port started working, I did not look into it any further, since 
it was a temporary setup just to get things going.

I looked for the original source from Movidis, and all I found in their 
kernel source were broken symlinks to a tool chain they that they did 
not give me :-(

Jan

>
> David Daney
>
