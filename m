Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0Q8k2416580
	for linux-mips-outgoing; Sat, 26 Jan 2002 00:46:02 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0Q8jkP16533
	for <linux-mips@oss.sgi.com>; Sat, 26 Jan 2002 00:45:46 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 437FC125C0; Fri, 25 Jan 2002 23:45:43 -0800 (PST)
Date: Fri, 25 Jan 2002 23:45:42 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: GNU C Library <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: A linuxthreads bug on mips?
Message-ID: <20020125234542.A31028@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Here is a modified ex2.c which only uses one conditional variable. It
works fine on x86. But it leads to dead lock on mips where both
producer and consumer are suspended. Is this testcase correct?


H.J.
----
/* The classic producer-consumer example.
   Illustrates mutexes and conditions.
   All integers between 0 and 9999 should be printed exactly twice,
   once to the right of the arrow and once to the left. */

#include <stdio.h>
#include "pthread.h"

#define BUFFER_SIZE 16

#define thread_cycles 10
#define thread_pairs 10
#define iters 10000

/* Circular buffer of integers. */

struct prodcons
{
  int buffer[BUFFER_SIZE];	/* the actual data */
  pthread_mutex_t lock;		/* mutex ensuring exclusive access to buffer */
  int readpos, writepos;	/* positions for reading and writing */
  pthread_cond_t cond;	/* signaled when buffer is not empty nor full */
};

/* Initialize a buffer */
static void
init (struct prodcons *b)
{
  pthread_mutex_init (&b->lock, NULL);
  pthread_cond_init (&b->cond, NULL);
  b->readpos = 0;
  b->writepos = 0;
}

/* Store an integer in the buffer */
static void
put (struct prodcons *b, int data)
{
  pthread_mutex_lock (&b->lock);
  /* Wait until buffer is not full */
  while ((b->writepos + 1) % BUFFER_SIZE == b->readpos)
    {
      pthread_cond_wait (&b->cond, &b->lock);
      /* pthread_cond_wait reacquired b->lock before returning */
    }
  /* Write the data and advance write pointer */
  b->buffer[b->writepos] = data;
  b->writepos++;
  if (b->writepos >= BUFFER_SIZE)
    b->writepos = 0;
  /* Signal that the buffer is now not empty */
  pthread_cond_signal (&b->cond);
  pthread_mutex_unlock (&b->lock);
}

/* Read and remove an integer from the buffer */
static int
get (struct prodcons *b)
{
  int data;
  pthread_mutex_lock (&b->lock);
  /* Wait until buffer is not empty */
  while (b->writepos == b->readpos)
    {
      pthread_cond_wait (&b->cond, &b->lock);
    }
  /* Read the data and advance read pointer */
  data = b->buffer[b->readpos];
  b->readpos++;
  if (b->readpos >= BUFFER_SIZE)
    b->readpos = 0;
  /* Signal that the buffer is now not full */
  pthread_cond_signal (&b->cond);
  pthread_mutex_unlock (&b->lock);
  return data;
}

/* A test program: one thread inserts integers from 1 to 10000,
   the other reads them and prints them. */

#define OVER (-1)

static void *
producer (void *data)
{
  struct prodcons *buffer = (struct prodcons *) data;
  int n;
  for (n = 0; n < 10000; n++)
    {
#if 0
      printf ("%d --->\n", n);
#endif
      put (buffer, n);
    }
  put (buffer, OVER);
  return NULL;
}

static void *
consumer (void *data)
{
  struct prodcons *buffer = (struct prodcons *) data;
  int d;
  while (1)
    {
      d = get (buffer);
      if (d == OVER)
	break;
#if 0
      printf ("---> %d\n", d);
#endif
    }
  return NULL;
}

struct prodcons buffer [thread_pairs];

int
main (void)
{
  pthread_t prod[thread_pairs];
  pthread_t cons[thread_pairs];
  int i, j;

  for (i = 0; i < thread_pairs; i++)
    init (&buffer [i]);

  for (j = 0; j < thread_cycles; j++)
    {
      for (i = 0; i < thread_pairs; i++)
	{
	  pthread_create (&prod[i], NULL, producer, (void *) &(buffer [i]));
	  pthread_create (&cons[i], NULL, consumer, (void *) &(buffer [i]));
	}

      for (i = 0; i < thread_pairs; i++)
	{
	  pthread_join (prod[i], NULL);
	  pthread_join (cons[i], NULL);
	}
    }

  return 0;
}
