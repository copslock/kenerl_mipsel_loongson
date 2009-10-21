Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Oct 2009 20:17:16 +0200 (CEST)
Received: from hofr.at ([212.69.189.236]:54212 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493685AbZJUSRJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Oct 2009 20:17:09 +0200
Received: by mail.hofr.at (Postfix, from userid 1002)
	id CF4F24F8B50; Wed, 21 Oct 2009 20:17:05 +0200 (CEST)
Date:	Wed, 21 Oct 2009 20:17:05 +0200
From:	Nicholas Mc Guire <der.herr@hofr.at>
To:	Steven Rostedt <rostedt@goodmis.org>
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Wu Zhangjin <wuzhangjin@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH -v4 9/9] tracing: add function graph tracer support for
	MIPS
Message-ID: <20091021181705.GA5218@opentech.at>
References: <af3ec1b5cd06b6f6a461c9fa7d09a51fabccb08d.1256135456.git.wuzhangjin@gmail.com> <a6f2959a69b6a77dd32cc36a5c8202f97d524f1e.1256135456.git.wuzhangjin@gmail.com> <53bdfdd95ec4fa00d4cc505bb5972cf21243a14d.1256135456.git.wuzhangjin@gmail.com> <1256141540.18347.3118.camel@gandalf.stny.rr.com> <4ADF38D5.9060100@caviumnetworks.com> <1256143568.18347.3169.camel@gandalf.stny.rr.com> <4ADF3FE0.5090104@caviumnetworks.com> <1256145813.18347.3210.camel@gandalf.stny.rr.com> <4ADF4982.9010306@caviumnetworks.com> <1256148562.18347.3264.camel@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1256148562.18347.3264.camel@gandalf.stny.rr.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <hofrat@hofr.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: der.herr@hofr.at
Precedence: bulk
X-list: linux-mips

> 
> 
> We're not doing back traces. We need to modify the return of the
> function being called. Note, the above functions that end with ";" are
> leaf functions. Non leaf functions show "{" and end with "}".
> 
> The trick here is to find a reliable way to modify the return address.
>
would it not more or less be the same thing if you used -finstrument-functions
then and provide a stub __cyg_profile_func_enter/exit initialized to an empty
function until you replace it during tracing. This does give you an overhead
when you are not tracing - but it would make the tracer implementation quite
generic.

hofrat 
