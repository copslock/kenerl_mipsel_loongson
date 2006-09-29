Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Sep 2006 02:56:51 +0100 (BST)
Received: from ns2.nec.com.au ([147.76.180.2]:3005 "EHLO ns2.nec.com.au")
	by ftp.linux-mips.org with ESMTP id S20039195AbWI2B4t (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 29 Sep 2006 02:56:49 +0100
Received: from smtp1.nec.com.au (unknown [172.31.8.18])
	by ns2.nec.com.au (Postfix) with ESMTP id AE6543B6B3
	for <linux-mips@linux-mips.org>; Fri, 29 Sep 2006 11:56:42 +1000 (EST)
Received: from [147.76.208.162] ([147.76.208.162])
	by tns.neca.nec.com.au (8.12.8/8.12.8) with ESMTP id k8T220Zl002497
	for <linux-mips@linux-mips.org>; Fri, 29 Sep 2006 12:02:00 +1000
Message-ID: <451C7CE7.8040909@nec.com.au>
Date:	Fri, 29 Sep 2006 11:54:47 +1000
From:	Pak Woon <pak.woon@nec.com.au>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Introduction and problems cloning repository
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <pak.woon@nec.com.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pak.woon@nec.com.au
Precedence: bulk
X-list: linux-mips

Hello All,

First time poster to this mailing list so if I am not following the 
correct protocol please let me know.

Introduction. I am a firmware developer working for NEC Australia. We 
are currently developing a MIPS SOC device made by Wintegra.

I am trying to clone the linux-malta.git repository using the command
"git clone http://ftp.linux-mips.org/pub/scm/linux-malta.git 
./linux-malta.git" but I receieve an "error: Can't lock ref". I have to 
use http because I am sure port 9418 is blocked by the sysadmin

Regards,
Pak
