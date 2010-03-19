Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Mar 2010 23:04:18 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:14479 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491070Ab0CSWEP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Mar 2010 23:04:15 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ba3f4e60000>; Fri, 19 Mar 2010 15:04:22 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 19 Mar 2010 15:03:29 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 19 Mar 2010 15:03:29 -0700
Message-ID: <4BA3F4AC.5000307@caviumnetworks.com>
Date:   Fri, 19 Mar 2010 15:03:24 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8) Gecko/20100301 Fedora/3.0.3-1.fc12 Thunderbird/3.0.3
MIME-Version: 1.0
To:     Jan Rovins <janr@adax.com>
CC:     Peter 'p2' De Schrijver <p2@debian.org>, linux-mips@linux-mips.org
Subject: Re: linux 2.6.33 on movidis x16
References: <20100305141113.GD2437@apfelkorn> <4B9EB45D.8050106@adax.com> <20100318181734.GG2437@apfelkorn> <4BA27048.2010707@caviumnetworks.com> <4BA277FB.6080808@adax.com> <20100319175244.GH2437@apfelkorn> <4BA3DE2D.1070801@adax.com>
In-Reply-To: <4BA3DE2D.1070801@adax.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Mar 2010 22:03:29.0626 (UTC) FILETIME=[021013A0:01CAC7B0]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26277
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 03/19/2010 01:27 PM, Jan Rovins wrote:


>       case CVMX_BOARD_TYPE_KBP: /* JLR first Movidis X16 */
>	case CVMX_BOARD_TYPE_CUST_WSX16: /* JLR second Movidis X16 */
>            /* Board has 8 SGMII ports. 4 connect out, two connect to a switch,
>                and 2 loop to each other */
>            if ((ipd_port >= 0) && (ipd_port < 4))
>                return ipd_port+1;
>            else
>                return -1;

I don't think that is correct.  I just verified that that PHYs are on
addresses 0-7.  That code makes them start at 1.

The Octeon mdio bus driver also needs a small change.

I am working on a patch.

David Daney
