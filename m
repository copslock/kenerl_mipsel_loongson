Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Oct 2009 01:56:11 +0200 (CEST)
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:54121 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493237AbZJSX4F convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Oct 2009 01:56:05 +0200
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 24437A795A;
	Mon, 19 Oct 2009 19:56:04 -0400 (EDT)
Received: from web8.messagingengine.com ([10.202.2.217])
  by compute1.internal (MEProxy); Mon, 19 Oct 2009 19:56:04 -0400
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:from:to:mime-version:content-transfer-encoding:content-type:references:subject:in-reply-to:date; s=smtpout; bh=AgfdDMWWW2Kf3Q29EyQJZvEf+Ys=; b=NSr2otjSTsAOXqtD/q1sUo3W/VWv+jHhLp+sbXmkDz8f8fUv1NDZQ8eJwHVv78SwoRTDEmPbh7T+mix/itx1xMttKKv2sN6RrawxURr6MfATLEeE2xnjaIyJ5dNxl5qWmPIydG4uCtt1CPnWiINtlng6N53QTVvf2+uI7ZJTP5w=
Received: by web8.messagingengine.com (Postfix, from userid 99)
	id 61B60645D5; Mon, 19 Oct 2009 19:56:04 -0400 (EDT)
Message-Id: <1255996564.10560.1340920621@webmail.messagingengine.com>
X-Sasl-Enc: TogQ+tWTmjYTEg/KEIDVTuuaXhcqTPrePlTdpl0gCMBZ 1255996564
From:	myuboot@fastmail.fm
To:	linux-kernel@vger.kernel.org,
	"linux-mips" <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: MessagingEngine.com Webmail Interface
References: <1255735395.30097.1340523469@webmail.messagingengine.com>
 <4AD906D8.3020404@caviumnetworks.com>
Subject: serial port 8250 messed up after coverting from little endian to big
 endian on kernel  2.6.31
In-Reply-To: <4AD906D8.3020404@caviumnetworks.com>
Date:	Mon, 19 Oct 2009 18:56:04 -0500
Return-Path: <myuboot@fastmail.fm>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: myuboot@fastmail.fm
Precedence: bulk
X-list: linux-mips

I am trying to bringup a MIPS32 board using 2.6.31. It is working in
little endian mode. After changing the board's hardware from little
endian to bit endian, the serial port print messed up. It prints now
something like - "‡‡‡‡‡‡‡‡‡‡‡‡‡‡‡‡" on the screen. When I trace the
execution, I can see the string the kernel is trying print is correct -
"Linux version 2.6.31 ..." and etc.

I guess it means the initialization of the serial port is not properly
done. But I am not sure where I should check for the problem. The serial
port device I am using is 8250. Please give me some advise.

Thanks. 
