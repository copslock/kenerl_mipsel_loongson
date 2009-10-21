Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Oct 2009 20:26:30 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9742 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492791AbZJUS0X (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 21 Oct 2009 20:26:23 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4adf52270001>; Wed, 21 Oct 2009 11:25:43 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 21 Oct 2009 11:25:42 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 21 Oct 2009 11:25:42 -0700
Message-ID: <4ADF5225.40701@caviumnetworks.com>
Date:	Wed, 21 Oct 2009 11:25:41 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	rostedt@goodmis.org
CC:	Wu Zhangjin <wuzhangjin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org, Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH -v4 9/9] tracing: add function graph tracer support for
 MIPS
References: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com>	 <3f0d3515f74a58f4cfd11e61b62a129fdc21e3a7.1256135456.git.wuzhangjin@gmail.com>	 <ea8aa927fbd184b54941e4c2ae0be8ea0b4f6b8a.1256135456.git.wuzhangjin@gmail.com>	 <96110ea5dd4d3d54eb97d0bb708a5bd81c7a50b5.1256135456.git.wuzhangjin@gmail.com>	 <5dda13e8e3a9c9dba4bb7179183941bda502604f.1256135456.git.wuzhangjin@gmail.com>	 <af3ec1b5cd06b6f6a461c9fa7d09a51fabccb08d.1256135456.git.wuzhangjin@gmail.com>	 <a6f2959a69b6a77dd32cc36a5c8202f97d524f1e.1256135456.git.wuzhangjin@gmail.com>	 <53bdfdd95ec4fa00d4cc505bb5972cf21243a14d.1256135456.git.wuzhangjin@gmail.com>	 <1256141540.18347.3118.camel@gandalf.stny.rr.com>	 <4ADF38D5.9060100@caviumnetworks.com>	 <1256143568.18347.3169.camel@gandalf.stny.rr.com>	 <4ADF3FE0.5090104@caviumnetworks.com>	 <1256145813.18347.3210.camel@gandalf.stny.rr.com>	 <4ADF4982.9010306@caviumnetworks.com> <1256148562.18347.3264.camel@gandalf.stny.rr.com>
In-Reply-To: <1256148562.18347.3264.camel@gandalf.stny.rr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2009 18:25:42.0038 (UTC) FILETIME=[E59FA360:01CA527B]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Steven Rostedt wrote:
[...]
> We're not doing back traces. We need to modify the return of the
> function being called. Note, the above functions that end with ";" are
> leaf functions. Non leaf functions show "{" and end with "}".
> 
> The trick here is to find a reliable way to modify the return address.
> 

Well that's what I get for chiming in without fully understanding the 
context.

I think it is fine to search backwards from the ($ra - 8) of the call to 
_mcount until you encounter the adjustment of $sp.  If you encounter a 
store of $ra, you can assume that the function will use the stored value 
when returning, otherwise modify the value restored to $ra (passed in 
$at).  That is probably what you were doing to begin with.

David Daney
