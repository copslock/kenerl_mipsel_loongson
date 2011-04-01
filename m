Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Apr 2011 20:42:42 +0200 (CEST)
Received: from sj-iport-2.cisco.com ([171.71.176.71]:19749 "EHLO
        sj-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491832Ab1DASmf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Apr 2011 20:42:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=msundius@cisco.com; l=401; q=dns/txt;
  s=iport; t=1301683355; x=1302892955;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=ifSnFS60L/+GJEkut02Z5ikgbokeyw19FOhTWRc6PBk=;
  b=QMJ/ckTFNKmHzwLtZPB1xULMKxhyxL7XnJZzT12ra/DMjT7Ka6yLI63E
   7Km0JDfPGw30YiOp0sJcdF+eT1TB57QUQDZhDZXdHSZ68Y2ulIW7asmYi
   +ToKCmOCkSSi6rIkqjJtUEq2P0a6FCD8We2zhFgZHYAtj6r6TedG4Ayj0
   s=;
X-IronPort-AV: E=Sophos;i="4.63,283,1299456000"; 
   d="scan'208";a="329149870"
Received: from mtv-core-1.cisco.com ([171.68.58.6])
  by sj-iport-2.cisco.com with ESMTP; 01 Apr 2011 18:41:46 +0000
Received: from msundius-lnx1.corp.sa.net (dhcp-171-71-47-156.cisco.com [171.71.47.156])
        by mtv-core-1.cisco.com (8.14.3/8.14.3) with ESMTP id p31Ifk7D028581;
        Fri, 1 Apr 2011 18:41:46 GMT
Message-ID: <4D961C6A.9070808@cisco.com>
Date:   Fri, 01 Apr 2011 11:41:46 -0700
From:   Michael Sundius <msundius@cisco.com>
User-Agent: Thunderbird 2.0.0.23 (X11/20090825)
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>
CC:     Kevin Cernekee <cernekee@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David VomLehn <dvomlehn@cisco.com>,
        Dave Hansen <dave@linux.vnet.ibm.com>,
        Andy Whitcroft <apw@shadowen.org>,
        Jon Fraser <jfraser@broadcom.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH v2] MIPS: Kernel crashes on boot with SPARSEMEM + HIGHMEM
 enabled
References: <c300b67a7a723369872c0b9a023d0b2e@localhost> <4D9603D8.2010709@caviumnetworks.com>
In-Reply-To: <4D9603D8.2010709@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <msundius@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29676
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: msundius@cisco.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:
>
>
> I think this may do the same thing as my patch:
>
> http://patchwork.linux-mips.org/patch/1988/
>
> Although my patch had different motivations, and changes some other 
> things around too.
>
> David Daney
>
I'm not really sure why your kernel or initrd would be in memory was not 
within
the range that had been accounted for.  are you saying its in high mem?
