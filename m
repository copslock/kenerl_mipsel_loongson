Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7G7xlRw027949
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 16 Aug 2002 00:59:47 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7G7xlGl027948
	for linux-mips-outgoing; Fri, 16 Aug 2002 00:59:47 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from v-wall.ihep.ac.cn (v-wall.ihep.ac.cn [202.38.128.171])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7G7xRRw027938
	for <linux-mips@oss.sgi.com>; Fri, 16 Aug 2002 00:59:32 -0700
Received: from mail.ihep.ac.cn (v-wall.ihep.ac.cn [127.0.0.1])
	by v-wall.ihep.ac.cn (8.11.6/8.11.6) with ESMTP id g7G7pau26656
	for <linux-mips@oss.sgi.com>; Fri, 16 Aug 2002 15:51:36 +0800
Received: from bixy (nsg.ihep.ac.cn [202.38.128.36])
	by mail.ihep.ac.cn (8.11.6/8.11.6) with SMTP id g7G7uvR08742
	for <linux-mips@oss.sgi.com>; Fri, 16 Aug 2002 15:56:57 +0800
Message-Id: <200208160756.g7G7uvR08742@mail.ihep.ac.cn>
Date: Fri, 16 Aug 2002 16:1:48 +0800
From: "±ÏÑ§Ò¢" <bxy@mail.ihep.ac.cn>
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: irq handle of sb1250
X-mailer: Foxmail 4.1 [cn]
Mime-Version: 1.0
Content-Type: multipart/mixed;
      boundary="=====000_Dragon468832073236_====="
X-Spam-Status: No, hits=-0.4 required=5.0 tests=SUPERLONG_LINE version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.

--=====000_Dragon468832073236_=====
Content-Type: text/plain;
      charset="GB2312"
Content-Transfer-Encoding: 7bit

hi, who is using sb1250/swarm board? i have mapped all the interrupts of second cpu to IP7(default IP2). after changing irq.c and irq_handler.S, second cpu can't get any interrupt. I don't know why it is. 


--=====000_Dragon468832073236_=====
Content-Type: image/gif;
      name="LittleBoy.GIF"
Content-Disposition: FoxmailIcon;
      filename="LittleBoy.GIF"
Content-Transfer-Encoding: base64

R0lGODlhIAAgANQAAGCXzwCAgGBnYP/IkPzJmpFjPBsNA2Q8HxQDACIGAk4HADYDAA0AAP///wAA
ANPT05KSkm5ubmVlZUZGRiUlJRgYGBEREQ8PDwcHBwMDAwAAAAAAAAAAAAAAAAAAAAAAACH/C05F
VFNDQVBFMi4wAwEAAAAh/sJodHRwOi8vd3d3LnJ0bHNvZnQuY29tL2FuaW1hZ2ljLwoKQ3JlYXRl
ZCB3aXRoIEFuaW1hZ2ljIEdJRiBWIDEuMjJhCmJ5IFJpZ2h0IHRvIExlZnQgU29mdHdhcmUgSW5j
LgoKVG8gc3VwcHJlc3MgdGhpcyBtZXNzYWdlIGluIHRoZSByZWdpc3RlcmVkIHZlcnNpb24KdW5j
aGVjayAiT3B0aW9ucyB8IEFuaW1hZ2ljIGNvbW1lbnQgZnJhbWUiCgAh+QQJGQABACwAAAAAIAAg
AAAF1mAgjmRpnmiqrqrjvjCLugNsO3LpDPz91rgcggf07XqyYa/nI9ZWytqy6HQGT1HrtEq8mhjc
45b7NImB5DTSrP6py6UoLfweLEwGpuBcJ95LYEANYm5vfyQOeQ4Ng12LfFyHIw5gi41AApdqkiIO
CUxdjJppnAGBYYyQBQUERAoleW2QRAWuJFmOfbW1rySnfVy7A70jsV3ARAc8xCO/RXNkC8rDWGGz
ZAgpzsgD2Srbfd4rCZ/ALjki5OXWXjKWoz2D6AEvooM2ojEtAADvqfz+BgE0EQIAIfkECRkAAQAs
AAAAACAAIAAABc5gII5kaZ5oqq6q474wi7oDbDty6Qz8/da4HIIH9O16smGv5yPWVsrasuh0Bk9R
67RKvJoY3OOW+zSJgeQ00qz+qculKC38HixMhum5TryXwFKBVHV+JA55R2KJhGZgMFt7XIUjDglM
XZhvkyKAYW5OBQUERAoleW2RRAWkJFldqVWrq6UknXxcsgO0I6eZtwMHPLsjtkVzZAvBulievwgp
xb8DzyrRfNQrCZa3Ljki2tueXjIODeaR5eMrL+bnNu0xLQAA5e0NDvP18PkmIQAh+QQJGQABACwA
AAAAIAAgAAAF02AgjmRpnmiqrqrjvjCLug9sO3LpPPz91rgchgf07XqyYa/nI9ZWytqy6HQGT1Hr
tEq8mjLc45b7NImB5DTSrP6py6UoLfx+VEwWpuRcJ95LYEANYm5vfyQOeQ4Ng12LfFyHIw5gi41A
EpdqkiIOF0xdjJppnAGBYYyQERFOFCV5bZBErDyuI1mOfaystiOnfVy7D70isF3ARBO1X1U2m8rD
WGGyZBgpv8g81irYwNsrF5/ALjki4eLTXjKWoz2D5QEvooM2ojEtEBDsqfn7g/0mQgAAOw==

--=====000_Dragon468832073236_=====--
