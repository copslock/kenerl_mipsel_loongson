Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Jan 2007 14:08:45 +0000 (GMT)
Received: from wf1.mips-uk.com ([194.74.144.154]:1245 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28577554AbXAIOIo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 9 Jan 2007 14:08:44 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l09E9XnY018320;
	Tue, 9 Jan 2007 14:09:33 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l09E9VV7018319;
	Tue, 9 Jan 2007 14:09:31 GMT
Date:	Tue, 9 Jan 2007 14:09:31 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	colin <colin@realtek.com.tw>
Cc:	linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: Re: Using 802.11x wireless usb device on MIPS platform
Message-ID: <20070109140931.GB6614@linux-mips.org>
References: <1cf601c73399$2ab7cd10$106215ac@realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cf601c73399$2ab7cd10$106215ac@realtek.com.tw>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13567
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 09, 2007 at 10:52:14AM +0800, colin wrote:

> I have used two 802.11x wireless usb devices successfully on MIPS platform.
> One is realtek 8187 and the other one is ralink 2571.
> I would like to put them into kernel tree and then I found that there are
> not many 802.11x devices supported in Linux.

If you want to submit a driver to the kernel, please post it to
netdev@vger.kernel.org.  Don't expect a driver to be just accepted; it
will go through a thorough review and after all the issues have been
resolved it will be accepted.

> Moreover, there is no any wireless usb device supported.

Wireless support under Linux is suffering from several problems:

 o some core require microcode to be loaded but the vendor does not
   give such permission.
 o lack of documentation, sometimes for paranoid or bogus legal reasons or
   "intellectual property" concerns.

At times it really seems vendors are working to maximize pain for the user ...

> It is also very strange that 8187 and 2571 both have their own ieee802.11x
> stack and crypt drivers. It seems that Linux doesn't offer them.
> I am wondering why Linux is so complex in 802.11x.

Well, for one thing because 802.11 is complex.  The Linux wireless support
has gone through several generations; some of the wireless work was for
one or the other reason never integrated in the kernel.org kernel.

  Ralf
