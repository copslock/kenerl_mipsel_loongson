Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 May 2007 00:16:44 +0100 (BST)
Received: from [69.90.147.196] ([69.90.147.196]:10957 "EHLO mail.kenati.com")
	by ftp.linux-mips.org with ESMTP id S20024476AbXEVXQm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 23 May 2007 00:16:42 +0100
Received: from [192.168.1.67] (adsl-71-130-109-177.dsl.snfc21.pacbell.net [71.130.109.177])
	by mail.kenati.com (Postfix) with ESMTP id 2DF6EE4052;
	Tue, 22 May 2007 16:21:55 -0700 (PDT)
Message-ID: <46537C2F.6010000@kenati.com>
Date:	Tue, 22 May 2007 16:26:39 -0700
From:	Carlos Munoz <carlos@kenati.com>
User-Agent: Thunderbird 1.5.0.10 (X11/20070306)
MIME-Version: 1.0
To:	sknauert@wesleyan.edu
CC:	linux-mips@linux-mips.org
Subject: Re: Cross-Compile difficulties
References: <20070516151939.GH19816@deprecation.cyrius.com>    <20070516160313.GA3409@bongo.bofh.it>    <50621.192.168.2.50.1179383217.squirrel@eppesuigoccas.homedns.org>    <20070517151636.GJ3586@deprecation.cyrius.com>    <20070521154726.GE5943@linux-mips.org>    <20070522110956.GB29118@linux-mips.org>    <1179834093.7896.23.camel@scarafaggio>    <34888.129.133.92.31.1179835313.squirrel@webmail.wesleyan.edu>    <20070522122808.GD32557@linux-mips.org>    <36324.129.133.92.31.1179840724.squirrel@webmail.wesleyan.edu>    <20070522151848.GB19833@networkno.de>    <33252.129.133.92.31.1179852417.squirrel@webmail.wesleyan.edu>    <Pine.LNX.4.64.0705221931380.11196@anakin> <51450.129.133.92.31.1179873846.squirrel@webmail.wesleyan.edu>
In-Reply-To: <51450.129.133.92.31.1179873846.squirrel@webmail.wesleyan.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <carlos@kenati.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15136
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carlos@kenati.com
Precedence: bulk
X-list: linux-mips

sknauert@wesleyan.edu wrote:
> make CROSS_COMPILE=mips-linux-gnu- oldconfig
> make -j 3 CROSS_COMPILE=mips-linux-gnu- all
> make CROSS_COMPILE=mips-linux-gnu- INSTALL_MOD_PATH=~/ modules_install
> cp vmlinux ~/boot/vmlinux-2.6.21.1
> cp System.map ~/boot/System.map-2.6.21.1
> cp .config ~/boot/config-2.6.21.1
> cd ~/
> tar -cf kernel.tar lib boot
>   
Don't know if it makes any difference, but I always specify the 
architecture on the command line:

make ARCH=mips -j 3 CROSS_COMPILE=mips-linux-gnu all
