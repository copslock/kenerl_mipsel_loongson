Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Jan 2007 23:54:13 +0000 (GMT)
Received: from mx5.wp.pl ([212.77.101.9]:41436 "EHLO mx1.wp.pl")
	by ftp.linux-mips.org with ESMTP id S28576309AbXAZXyL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 26 Jan 2007 23:54:11 +0000
Received: (wp-smtpd smtp.wp.pl 1422 invoked from network); 27 Jan 2007 00:53:04 +0100
Received: from apn-236-1.gprsbal.plusgsm.pl (HELO [87.251.236.1]) (laurentp@[87.251.236.1])
          (envelope-sender <laurentp@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with AES256-SHA encrypted SMTP
          for <linux-mips@linux-mips.org>; 27 Jan 2007 00:53:04 +0100
Message-ID: <45BA94FF.4080301@wp.pl>
Date:	Sat, 27 Jan 2007 00:55:43 +0100
From:	"W.P." <laurentp@wp.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: pl, en, en-us
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Beginning with REALTEK RTL-8186.
References: <5C1FD43E5F1B824E83985A74F396286E041B10FB@bby1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
In-Reply-To: <5C1FD43E5F1B824E83985A74F396286E041B10FB@bby1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-WP-AV: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-SPAM: NO 0000000                                      
Return-Path: <laurentp@wp.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: laurentp@wp.pl
Precedence: bulk
X-list: linux-mips

U¿ytkownik Don Hiatt napisa³:

>I'd certainly like to here about it. Well done.
>
>Cheers,
>
>don
> 
>
Let it be ;)

0). Model: EDIMAX BR-6204Wg, CPU: Realtek RTL-8186, bridge/NIC:
RTL-83055C, Flash: 1x MX-29LV160CBTC-70G, RAM: 2x PSC-.....

1). First of all, i have disassembled the device to get to it's serial
port. On PCB i've found a 4-pins header labeled JP2. Optical inspection
followed by ohmometer use shown that it is RTL's serial port. Pin
functions (from center to egde): +3.3Vcc, RxD (RTL's receiver), GND, TxD
(RTL's transmitter).
Then i connected an MAX232 level translator to those pins, using +3.3V
as power (CAUTION: 232 from Ti did not work @ 3.3V), as proposed on
mips-wiki pages. Parameters of transmission: 38400/8N1. BTW Edimax tech
support for Europe refused to tell if that header is serial.

2). On username/pass prompt working configuration was super/@gogolinux -
again from wiki.

3). Software instalation that comes from Edimax lacks nearly everything
;( no vi, not even ln.

4). Downloaded sources from Edimax Taiwanese site:
http://www.edimax.com.tw/download/drivers/GPL/BR-6204WG_GNU.tgz a little
71.5MB package. ;)
4a). what lacks from that tarball: /web directory, *.sh scripts from /bin
4b). using default build instructions found in tarball leads to lack of
webserver (webs), and two important other execs: /bin/setup and
/bin/flash. The latter is, as i realize an interface to store/fetch
variables from flash. The setup file SHOULD be in tarball: it is
referenced in build chain, but is missing (whole directory AP/console).
4c). I launched build, then I copied missing files from working system
and  then blocked script in rtl-11g-GPL/AP/mkimg/app_11g_script to NOT
regenerate top.11g directory. Then i ran build once again.

5). Flashed resulting bin file onto Edimax.

6). Boots OK, but have to manually start init.sh and webs& from serial
console.
6a). Much more options in Busybox enabled. ex: vi, ln, etc.

7). For this moment i have returned back to original (downloaded 1.48)
Edimax firmware.

Tomorrow I'll upload photos and boot-progress files somewhere.

W.P.

PS, there is a lot in configuration of this system, that i do not
understand clearly: ex: ifconfig shows: br0, br1 WITH ip-addresses,
eth0, eth1, wlan0 WITHOUT ip....
I'll have to investigate config files/scripts.
