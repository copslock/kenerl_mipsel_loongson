Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA08473 for <linux-archive@neteng.engr.sgi.com>; Wed, 14 Apr 1999 11:26:44 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA82841
	for linux-list;
	Wed, 14 Apr 1999 11:20:50 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.42.13])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA90414
	for <linux@engr.sgi.com>;
	Wed, 14 Apr 1999 11:20:49 -0700 (PDT)
	mail_from (ariel@oz.engr.sgi.com)
Received: (from ariel@localhost) by oz.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) id LAA81406 for linux@engr.sgi.com; Wed, 14 Apr 1999 11:20:48 -0700 (PDT)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199904141820.LAA81406@oz.engr.sgi.com>
Subject: NTools ENewsFlash -- Report: NT 3.5x Faster Than Linux
To: linux@cthulhu.engr.sgi.com (SGI/Linux mailing list)
Date: Wed, 14 Apr 1999 11:20:47 -0700 (PDT)
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

[I'm forwarding a message that bounced.  Just thought some people
 may be interested.  To add to what Eric wrote, another thing that
 I find strange is that they are comparing NT 3.5 rather than the
 latest NT 4.x to Linux.  I also believe some of the results
 are missing crucial details, like how the two very different
 web servers were configured (e.g. standalone vs from inetd,
 ssi turned on etc.) who paid for the report, full disclosures...
 -- Ariel]


---------- Forwarded message:
:Sender: eak@sgi.com
:Date: Wed, 14 Apr 1999 10:22:27 -0700
:From: Eric Kimminau <eak@sgi.com>
:Reply-To: eak@sgi.com
:Organization: Electronic Support Tools
:To: linux@engr.sgi.com
:Subject: [Fwd: NTools ENewsFlash -- Report: NT 3.5x Faster Than Linux]
:
:I honestly don't believe this. The primary key being that they made no
:kernel rebuild and they were using all modules rather than building
:things like raid support directly into the kernel.
:
:Their bandwidth utilization also stinks of using 10Mbit vs. 100Mbit
:during testing.
:
:They also give no indication of the kinds of data they were delivering
:(CGI, DHTML, java/javascript) nor the version/vendor for the
:webserver.
:
:This is Microsoft FUD.
:
:EAK.
:
:-- 
:---------1---------2---------3---------4---------5---------6---------7
:   Eric Kimminau        eak@sgi.com        Electronic Support Tools
:            Voice: (248) 848-4455    VNet:  6-327-4455
:                 "I speak my mind and no one else's."
: "I am a bomb technician. If you see me running, try to keep up..."
:                      http://support.sgi.com
:
:To: "Latest Win NT News" <nt-list@lyris.sunbelt-software.com>
:From: nt-list-admin@lyris.sunbelt-software.com
:List-Unsubscribe: <mailto:leave-nt-list-265937F@lyris.sunbelt-software.com>
:Reply-To: comments@lyris.sunbelt-software.com
:Message-Id: <LYR265937-44691-1999.04.14-08.19.09--eak#sgi.com@lyris.sunbelt-software.com>
:Precedence: bulk
:
:*****************************************************
:NTools E-NewsFlash: Report: NT 3.5x Faster Than Linux
:*****************************************************
:                    April 14, 1999
:
:Hi All,
:
:As most of you know, when some important news hits the
:wires we will inform you immediately. This morning I
:found something in my in-box that will definitely throw
:some more gasoline on the raging 'NT vs Linux' fire.
:
:I quickly read through the report and could not find
:anything wrong with it at first observation. The numbers
:seem to be correct, as they are using an industry standard
:benchmark that I have used myself as well, the ZD bench.
:
:Oh, before I forget, Novell actually wrote a rebuttal 
:against that last report that SMS is better than ZEN.
:Interesting reading, and this gives the Novell POV:
:http://www.novell.com/products/nds/zenworks/ms2.html
:
:But here comes today's bomb in the NT vs Linux battle.
:One wonders who pays for these tests but I will ask the
:CEO of MindCraft and report on that in the next coming
:newsletter. Here goes!
:
:
:LOS GATOS, Calif., April 13. Today, Mindcraft released the results 
:of a study comparing the performance of Red Hat Linux 5.2 (updated 
:to the Linux 2.2.2 kernel) and Microsoft Windows NT Server 4.0 
:operating systems. According to the report, Windows NT Server 
:provides over three and a half times the performance of Linux as a
:Web server.  Furthermore, the report shows that when testing Windows 
:NT Server and Linux as file servers, Windows NT Server provides over 
:two and a half times the performance of Linux.  The full report,
:including all of the details needed to reproduce the tests, is on
:Mindcraft's Web site at:
:
:http://www.mindcraft.com/whitepapers/nts4rhlinux.html.
:
:Using benchmarks from Ziff-Davis Benchmark Operation (ZDBOp), the 
:report compares the peak performance levels of both Windows NT 
:Server and Linux configured both as a file server and a Web server.   
:
:All tests were performed on a standard Dell PowerEdge 6300/400 server 
:with four 400-MHz Xeon CPUs, 1GB RAM (960MB for Linux -- this is the
:default maximum amount of RAM that Linux supports).  To simulate a 
:client load, Mindcraft used 144 physical client test systems; half 
:were running Windows 95 and the other half were running Windows 98.  
:
:Both Linux and Windows NT Server were tuned to perform optimally under
:each of the two workloads.  "We started the tests using standard Red Hat
:Linux 5.2 but had to update it because it does not support hardware RAID
:controllers and SMP at the same time," said Mindcraft's president, Bruce
:Weiner.  "Linux definitely takes more time and resources to tune and to
:configure than Windows NT Server.  You have to search the Net to find the
:latest kernel and driver versions to get the highest performance and most
:reliable modules. Then when you're done, Linux fails to deliver the same
:level of performance as Windows NT Server on enterprise-class servers."
:
:Mindcraft's report shows that using ZDBOp's WebBench 2.0 Web server
:benchmark, Windows NT Server and Internet Information Server (IIS) 4.0
:reach a peak of 3,771 requests/second and 22.4 Megabits/second(Mbps) of
:throughput. The report goes on to show that Linux and the Apache 1.3.4 
:Web server reach a peak of 1,000 request/second and 5.9 Mbps of
:throughput.  The WebBench 2.0 tests also revealed that there are problems
:with Linux/Apache at high client loads. "The Linux/Apache Web server
:performance collapsed with a WebBench load above 160 client test threads,
:while Windows NT Server/IIS continued to increase performance up through
:288 client test threads without reaching their peak performance," adds 
:Mindcraft's Bruce Weiner.
:
:To simulate a file server workload, Mindcraft used ZDBOp's NetBench 
:5.01 benchmark.  The testing revealed that Windows NT Server performance
:peaked at 286.7 Mbps with 112 clients, while Linux running Samba 2.0.1
:peaked at 114.6 Mbps with only 48 clients.  "The integration of the SMB
:file sharing protocol with the multi-processor kernel is a key performance
:win for Windows NT Server," said Weiner. "Customers benefit every day from
:the superior scalability of Windows NT Server, which delivers vital file
:and web services at two to three times the performance of Linux as shown
:in these benchmarks," said Edmund Muth, Group Product Manager, Microsoft
:Corporation. "Empirical data like this helps customers and planners make
:informed decisions, and showcases the industrial strength technology and
:mature engineering of the Windows NT Server operating system."
:
:About Mindcraft
:
:Mindcraft is a service-oriented, independent test lab. The company was
:founded in 1985 to provide high quality services and products to vendors
:and end users who want to test software, system, and network products.
:Mindcraft is committed to work to promote standards in our industry.
:Mindcraft is the only test lab to be a member of the Standard Performance
:Evaluation Corporation (SPEC).
:--------------------------------------
:
:That's all for this NewsFlash!
:
:Warm regards,
:
:Stu
:
:
:[eak@sgi.com] This is a posting from the
:nt-list, To unsubscribe, send a blank email 
:to leave-nt-list-265937F@lyris.sunbelt-software.com
:For killer servers at unbelievable prices check out:
:http://www.dell.com/outlet/sunbelt.htm 
:
:


-- 
Peace, Ariel
