Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2003 01:24:47 +0100 (BST)
Received: from avtrex.com ([IPv6:::ffff:216.102.217.178]:64791 "EHLO
	avtrex.com") by linux-mips.org with ESMTP id <S8224802AbTGPAYp>;
	Wed, 16 Jul 2003 01:24:45 +0100
Received: from avtrex.com ([192.168.0.111]) by avtrex.com with Microsoft SMTPSVC(5.0.2195.5329);
	 Tue, 15 Jul 2003 17:24:41 -0700
Message-ID: <3F149B49.9010303@avtrex.com>
Date: Tue, 15 Jul 2003 17:24:41 -0700
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Help wanted WRT multigot...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Jul 2003 00:24:41.0655 (UTC) FILETIME=[A644DC70:01C34B30]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

We are using gcj/gcc-3.3 to run java programs on a mipsel-linux 
platform, and were able to work around GOT overflow error by hacking the 
  build to pass -xgot to gas.

After searching the web, it appeared that using binutils 2.14 or 
binutils-2.14.90.0.4 might enable multigot objects.  However it not 
clear to me if there is multigot support in these versions of binutils, 
or how to turn it on if there is.

Is there a multigot assembler/linker that can be used with gcc-3.3?

Or are we stuck with -xgot?

Thanks in advance,

David Daney
