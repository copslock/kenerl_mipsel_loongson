Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Nov 2004 15:21:18 +0000 (GMT)
Received: from pimout3-ext.prodigy.net ([IPv6:::ffff:207.115.63.102]:463 "EHLO
	pimout3-ext.prodigy.net") by linux-mips.org with ESMTP
	id <S8225002AbUKCPVL>; Wed, 3 Nov 2004 15:21:11 +0000
Received: from berloga.paulidav.org (adsl-67-116-37-218.dsl.sntc01.pacbell.net [67.116.37.218])
	by pimout3-ext.prodigy.net (8.12.10 milter /8.12.10) with ESMTP id iA3FL35g357976;
	Wed, 3 Nov 2004 10:21:06 -0500
Received: from paulidav.org (berloga.paulidav.org [67.116.37.218])
	by berloga.paulidav.org (Postfix) with ESMTP
	id B1DECB940; Wed,  3 Nov 2004 07:21:02 -0800 (PST)
Message-ID: <4188F75E.9010105@paulidav.org>
Date: Wed, 03 Nov 2004 07:21:02 -0800
From: "Vladimir A. Gurevich" <vag@paulidav.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: colin <colin@realtek.com.tw>
Cc: linux-mips@linux-mips.org
Subject: Re: KGDB: I cannot stop execution by using "ctrl+c"
References: <01e101c4c182$5d0f2780$8b1a13ac@realtek.com.tw>
In-Reply-To: <01e101c4c182$5d0f2780$8b1a13ac@realtek.com.tw>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <vag@paulidav.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6256
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vag@paulidav.org
Precedence: bulk
X-list: linux-mips

Hello Colin,

colin wrote:

>When using gdb to debug Linux kernel, I found that it cannot be stopped
>temporarily by using "ctrl+c".
>After the first strike of "ctrl+c", nothing happen.
>After the second, Linux kernel will show these messages:
>    Interrupted while waiting for the program.
>    Give up (and stop debugging it)? (y or n)
>If choose yes, kernel will totally stop and it goes back to gdb shell.
>How can I stop kernel temporarily and then resume it?
>
You should use the following command in GDB:

    set remotebreak 1

After that it will start to behave as you expect it to, i.e. it will 
interrupt the kernel as soon as you press CTRL-C.

Happy hacking,
Vladimir
