Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Apr 2013 09:06:52 +0200 (CEST)
Received: from demumfd002.nsn-inter.net ([93.183.12.31]:13814 "EHLO
        demumfd002.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835120Ab3DOHGtVbaMC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Apr 2013 09:06:49 +0200
Received: from demuprx017.emea.nsn-intra.net ([10.150.129.56])
        by demumfd002.nsn-inter.net (8.12.11.20060308/8.12.11) with ESMTP id r3F76g5R026772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 15 Apr 2013 09:06:42 +0200
Received: from [10.151.24.91] ([10.151.24.91])
        by demuprx017.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id r3F76fNA014633;
        Mon, 15 Apr 2013 09:06:41 +0200
Message-ID: <516BA701.6060904@nsn.com>
Date:   Mon, 15 Apr 2013 09:06:41 +0200
From:   Alexander Sverdlin <alexander.sverdlin.ext@nsn.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To:     ext David Daney <ddaney@caviumnetworks.com>
CC:     linux-mips@linux-mips.org, david.daney@cavium.com,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH V2] Octeon: fix broken plat_mem_setup()
References: <51683BCB.8060209@nsn.com> <51684012.2020602@caviumnetworks.com>
In-Reply-To: <51684012.2020602@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 702
X-purgate-ID: 151667::1366009602-00004D0E-40C65535/0-0/0-0
Return-Path: <alexander.sverdlin.ext@nsn.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36164
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.sverdlin.ext@nsn.com
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

Hi!

On 04/12/2013 07:10 PM, ext David Daney wrote:
> On 04/12/2013 09:52 AM, Alexander Sverdlin wrote:
>> Octeon: fix broken plat_mem_setup()
>>
>
> I have a different patch I am testing that gets rid of all this crap.

You can also send it to me for testing if you want...

> The strategy we are using is to use cvmx_bootmem named blocks for all memory in a KEXEC environment.

Kernel image still must be mapped to appear in /proc/iomem...
Because there are two use cases of KEXEC: crashkernel (that is considered more often) and just a normal reboot of the same kernel,
which needs old kernel image mapped... I've been testing later one...

-- 
Best regards,
Alexander Sverdlin.
