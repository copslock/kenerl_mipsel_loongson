Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Mar 2004 22:21:26 +0000 (GMT)
Received: from server212.com ([IPv6:::ffff:203.194.159.163]:16000 "HELO
	server212.com") by linux-mips.org with SMTP id <S8225547AbUCYWVZ>;
	Thu, 25 Mar 2004 22:21:25 +0000
Received: (qmail 25908 invoked by uid 501); 25 Mar 2004 22:22:42 -0000
Message-ID: <20040325222241.3445.qmail@server212.com>
Reply-To: "wlacey" <wlacey@goldenhindresearch.com>
From: "wlacey" <wlacey@goldenhindresearch.com>
To: linux-mips@linux-mips.org
Subject: RPC: exit -512 [ERESTARTSYS]
Date: Thu, 25 Mar 2004 22:22:41 
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="_b381d0372eadef7eeaa16df39eec9e828"
X-Mailer: WebMail 2.3
X-Originating-IP: 65.60.157.128
X-Originating-Email: wlacey@goldenhindresearch.com
Return-Path: <wlacey@goldenhindresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4645
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wlacey@goldenhindresearch.com
Precedence: bulk
X-list: linux-mips

--_b381d0372eadef7eeaa16df39eec9e828
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

I'm bringing up a 2.4.18 version of the kernel on a tx4925 processor, using a NFS'ed root filesystem when the actual mount request RPC call fails w/-512

About line 662 in function __rpc_execute(), in file net/sunrpc/sched.c

if (task->tk_client->cl_intr && signalled())) {
        printk("RPC: got signal\n");
        task->tk_flags |= RPC_TASK_KILLED;
        rpc_exit(task, -ERESTARTSYS);
        rpc_wake_up_task(task);
  }
  }
  }

  if (task->tk_exit) {
     task->tk_exit(task);
     /* If tk_action is non-null, the user wants us to restart */
     if (task->tk_action) {
    ..
    ..

The problems is that rpc_exit() NULLS task->tk_action and I can't see how the task/RPC request gets re-generated.

Is anybody familiar w/this area of code? Why is the RPC call apparently not being re-generated?

Any help???

Thanks,
Warrick Lacey


--_b381d0372eadef7eeaa16df39eec9e828
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

I'm bringing up a 2.4.18 version of the kernel on a tx4925 processor, using a NFS'ed root filesystem when the actual mount request RPC call fails w/-512<br>
<br>
About line 662 in function __rpc_execute(), in file net/sunrpc/sched.c<br>
<br>
if (task-&gt;tk_client-&gt;cl_intr &amp;&amp; signalled())) {<br>
        printk(&quot;RPC: got signal\n&quot;);<br>
        task-&gt;tk_flags |= RPC_TASK_KILLED;<br>
        rpc_exit(task, -ERESTARTSYS);<br>
        rpc_wake_up_task(task);<br>
  }<br>
  }<br>
  }<br>
<br>
  if (task-&gt;tk_exit) {<br>
     task-&gt;tk_exit(task);<br>
     /* If tk_action is non-null, the user wants us to restart */<br>
     if (task-&gt;tk_action) {<br>
    ..<br>
    ..<br>
<br>
The problems is that rpc_exit() NULLS task-&gt;tk_action and I can't see how the task/RPC request gets re-generated.<br>
<br>
Is anybody familiar w/this area of code? Why is the RPC call apparently not being re-generated?<br>
<br>
Any help???<br>
<br>
Thanks,<br>
Warrick Lacey<br>
<br>


--_b381d0372eadef7eeaa16df39eec9e828--
