Received:  by oss.sgi.com id <S42271AbQIMGxq>;
	Tue, 12 Sep 2000 23:53:46 -0700
Received: from kayak.mcgary.org ([63.227.80.137]:28680 "EHLO kayak.mcgary.org")
	by oss.sgi.com with ESMTP id <S42270AbQIMGx0>;
	Tue, 12 Sep 2000 23:53:26 -0700
Received: (from gkm@localhost)
	by kayak.mcgary.org (8.9.3/8.9.3) id XAA20804;
	Tue, 12 Sep 2000 23:53:16 -0700
X-Authentication-Warning: kayak.mcgary.org: gkm set sender to greg using -f
To:     linux-mips@oss.sgi.com
Subject: Re: do_page_fault crash on Indigo2
References: <200009120107.SAA31731@kayak.mcgary.org>
From:   Greg McGary <greg@mcgary.org>
Date:   12 Sep 2000 23:53:15 -0700
In-Reply-To: Greg McGary's message of "Mon, 11 Sep 2000 18:07:17 -0700"
Message-ID: <msk8cgsrz8.fsf@mcgary.org>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Here's the call trace.  I'm sure the symbol-table corresponds to the
crashed system, but the trace looks bogus to me.  I should have a look
at the call-trace dumping code in linux.  Since I have already written
one of these things for an embedded system, I painfully aware that
tracing the stack at runtime for MIPS is fraught with peril.

> Call Trace: [<88033678>] [<8802f31c>] [<881347ac>] [<88134a78>] [<88010c88>] [<88009f88>] [<880114d8>] [<88009fe0>] [<88008000>] [<88009f80>] [<8800f78c>] [<880114dc>] [<88135ce0>] [<880025c4>]
> Code: 26315cf8  24100001  8c460004 <8cc30000> 00721024  00451024  1040005f  8dad0000  1320000e 
>>???; 88026e10 <__wake_up+80/3a0>   <=====

Trace; 88033678 <update_process_times+34/f8>
Trace; 8802f31c <tasklet_hi_action+a0/11c>
Trace; 881347ac <indy_local0_irqdispatch+c8/f4>
Trace; 88134a78 <__gnu_compiled_c+118/180>
Trace; 88010c88 <stack_done+1c/38>
Trace; 88009f88 <dummy+1f88/2000>
Trace; 880114d8 <r4k_wait+0/18>
Trace; 88009fe0 <dummy+1fe0/2000>
Trace; 88008000 <init_task_union+0/0>
Trace; 88009f80 <dummy+1f80/2000>
Trace; 8800f78c <__gnu_compiled_c+3c/60>
Trace; 880114dc <r4k_wait+4/18>
Trace; 88135ce0 <__gnu_compiled_c+410/2960>
Trace; 880025c4 <stext+40/a7c>
